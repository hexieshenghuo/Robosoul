#include "pvDetector.h"
#include "mainwindow.h"

pvDetector::pvDetector(QObject *parent):QThread(parent)
{
    TotalHeatSpotInfor.clear();
    RunCommand=PV_NOTHING;
    ThreadOn=0;
    StartFlag=0;
    FrameInterval=3;
    BeginPos=3;

    FilePath="./DetectVideos";

    GetVideoNamesFromPath(FilePath.c_str(),VideoNames);

    //控制指令
    cmdThreadStop=1;

    //算法参数
    heatconfig.EDnum = 2; //腐蚀膨胀次数设为2
    heatconfig.threshold = 217;//二值化阈值设为217

    CvCapture*Capture=cvCaptureFromAVI(VideoNames[0].c_str());
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    cvReleaseCapture(&Capture);

    ParamFileName="ProParam.rsc";
    proParam=new ProParam;
    rsLoadProParam(ParamFileName.c_str(),proParam,&(cvSize(Width,Height)));

    HeatSpotROI=cvRect(0,0,proParam->ImageSize.width,proParam->ImageSize.height);

}

pvDetector::~pvDetector()
{
    if(proParam)
    {
        delete proParam;
        proParam=0;
    }
    ReleaseRes();
}

int pvDetector::ReleaseRes()
{
    for(int i=0;i<ResImage.size();i++)
    {
        IplImage* res=ResImage[i];
        if(res)
        {
            cvReleaseImage(&res);
            ResImage[i]=0;
        }
    }
    ResImage.clear();

    return 0;
}

int pvDetector::GetVideoNamesFromPath(const char* Path,vector<string> &VideoNames,const char* postfix)
{
    VideoNames.clear();
    struct _finddata_t c_file;
    long handle_File;

    string FilePath=Path;
    FilePath+="\\*.";
    FilePath+=postfix;

    if( (handle_File = _findfirst( FilePath.c_str(), &c_file )) == -1L)
    {
        return -1;
    }
    else
    {
        string FileName=Path;
        FileName+="/";
        FileName+=c_file.name;
        VideoNames.push_back(FileName);
        while( _findnext( handle_File, &c_file ) == 0 )
        {
            string FileName=Path;
            FileName+="/";
            FileName+=c_file.name;
            VideoNames.push_back(FileName);
        }
    }
    _findclose( handle_File );
    return 0;
}

void  pvDetector::run()
{
    emit ShowMessage("Runing()......");
    for(;;)
    {
        if(cmdThreadStop==1)
        break;
        switch (RunCommand) {
        case PV_NOTHING:
            break;
        case PV_STITCH:
            StitchImage();
            cmdThreadStop=1;
            break;
        case PV_DETECT:
            VideosDetect();
            cmdThreadStop=1;
            break;
        default:
            break;
        }
        msleep(36);
    }

}

int pvDetector::StitchImage()
{
    emit ShowMessage("StitchImage() Running......");
    // 初始化

    // 拼接循环
    emit ShowMessage(QStringLiteral("Start Stitching......"));
    int Res= VideoStitch(StitchFileName.data());
    emit ShowMessage(QStringLiteral("Stitching Finished......"));

    return 0;
}

int pvDetector::ShowImage(IplImage* Image)
{
    QImage img((uchar*)Image->imageData, Image->width,Image->height, QImage::Format_RGB888);//Format_RGB888
    emit Display(img);
    return 0;
}

int pvDetector::HeatSpotDetect(IplImage* Image,CvRect ROI,vector<HeatSpotParam>& heatspotParam,HeatSpotConfig* heatspotConfig,int id,int Pos)
{
    IplImage* dst=cvCreateImage(cvSize(ROI.width,ROI.height),8,3);//创建图像空间
    //设置ROI区域
    cvSetImageROI(Image,ROI);
    //提取ROI
    cvCopy(Image,dst);
    //取消设置
    cvResetImageROI(Image);

    //获得图像的长和宽
    CvSize size = cvGetSize(dst);

    IplImage* huiduImg = cvCreateImage(size,8,1);//此时为全灰    注意释放
    IplImage* erzhiImg = cvCreateImage(size,8,1);//此时为全灰    注意释放

    //灰度变换
    cvCvtColor(dst,huiduImg,CV_BGR2GRAY);
    //二值化
    cvThreshold(huiduImg,erzhiImg,(*heatspotConfig).threshold,255,CV_THRESH_BINARY);
    cvReleaseImage(&huiduImg);
    IplImage* img = cvCreateImage(cvGetSize(erzhiImg),8,1);

    cvErode(erzhiImg,img,NULL,(*heatspotConfig).EDnum);//腐蚀1
    cvDilate(img,erzhiImg,NULL,(*heatspotConfig).EDnum);//膨胀1
    cvReleaseImage(&img);

    //***********轮廓提取*******************//
    //参数初始化
    CvMemStorage* storage = cvCreateMemStorage(0);
        IplImage* contoursImage  = cvCreateImage(cvSize(erzhiImg->width,erzhiImg->height),8,1); //创建原图大小的灰度图像 但此时为空
    CvSeq* contours = 0, *contoursTemp=0; //CvSeq是个结构体，又称为可动态增长元素序列
    cvZero(contoursImage); //一副黑色图像

    int total = 0;//total为轮廓数
    cvFindContours(erzhiImg,storage,&contours,sizeof(CvContour),//storage:返回轮廓的容器。contours:输出参数，用于存储指向第一个外接轮廓
                CV_RETR_LIST,CV_CHAIN_APPROX_NONE,cvPoint(0,0));
    //CV_RETR_EXTERNAL：只检索最外面的轮廓；
    //CV_RETR_LIST：检索所有的轮廓，并将其放入list中；
    //CV_RETR_CCOMP：检索所有的轮廓，并将他们组织为两层：顶层是各部分的外部边界，第二层是空洞的边界；
    //CV_RETR_TREE：检索所有的轮廓，并重构嵌套轮廓的整个层次。
    cvReleaseImage(&erzhiImg);
        erzhiImg=0;

    //对所有轮廓进行操作
    for(contoursTemp = contours;contoursTemp!=0;contoursTemp=contoursTemp->h_next)//h_next 访问外层 同层轮廓
    {
        int positionx = 0, positiony = 0, sumx = 0, sumy = 0;
        //求得每一个轮廓的面积
        double s = fabs(cvContourArea(contoursTemp));//轮廓面积
        double r1 = sqrt(s/CV_PI);
        double length = cvArcLength(contoursTemp);//轮廓周长
        double r2 = length/(2*CV_PI);
        int r=cvRound((r1+r2)/2.0);//区域半径
        //求每一个轮廓的中心
        for(int i=0;i < contoursTemp->total;i++) //提取其中一个轮廓所有坐标点
        {
            CvPoint* pt = (CvPoint*)cvGetSeqElem(contoursTemp,i);//读出第i个点的坐标
            sumx =sumx + pt->x;
            sumy = sumy + pt->y;
            if(i == (contoursTemp->total-1))
            {
                positionx = sumx/i;
                positiony = sumy/i;

                HeatSpotParam HSParam;
                HSParam.x = positionx;
                HSParam.y = positiony;
                HSParam.Radius = r;
                HSParam.ID=id;
                HSParam.Pos=Pos;
                heatspotParam.push_back(HSParam);
            }
        }

        //在原图中标记出满足条件的热斑
        for(int j=0;j<contoursTemp->total;j++)
        {
            CvPoint* pt = (CvPoint*)cvGetSeqElem(contoursTemp,j);//读出第j个点的坐标
            cvSetReal2D(contoursImage,pt->y,pt->x,255.0);//将图像contoursImage上的点描为白色
            cvSet2D(dst,pt->y,pt->x,cvScalar(255,0,0,0));//将图像src上的点描为蓝色（蓝，绿，红）
        }
        total++;
    }

        //

        cvClearSeq(contours);

        if (storage)
        {
            cvReleaseMemStorage(&storage);
            storage=0;
        }

        if(contoursImage)
        {
            cvReleaseImage(&contoursImage);
            contoursImage=0;
        }

        if(dst)
        {
            cvReleaseImage(&dst);
            dst=0;
        }

        if(huiduImg)
        {
            cvReleaseImage(&huiduImg);
            huiduImg=0;
        }

    return total;
}


//大津分割
int pvDetector::Otsu(IplImage* img)
{
    int i, j, k, height, width, num, gray;
    float n[256];
    float p[256];
    height = img->height;
    width = img->width;
    num = height * width;
    CvScalar s;
    double smax=-DBL_MAX, smin=DBL_MAX, //the max and min gray scale of the src image
          dmax=-DBL_MAX, dmin=DBL_MAX; //stretch the image's gray level from dmin to dmax

    CvScalar sa, da;

    for(i=0; i<height; i++)
    {
        for(j=0; j<width; j++)
        {
            sa = cvGet2D(img, i, j);
            if(smax < sa.val[0])
                smax = sa.val[0];
            if(smin>sa.val[0])
                smin = sa.val[0];
        }
    }
       double a, b;
       a = (dmax-dmin)/(smax-smin); //代码很危险!
       b = (smax*dmin - dmax*smin)/(smax - smin);
       if(a>1)
       {
       for(i=0; i<height; i++)
       {
          for(j=0; j<width; j++)
          {
             sa = cvGet2D(img, i, j);
             da.val[0] = a *  sa.val[0] + b;
             cvSet2D(img, i, j, da);
          }
       }
       }

       for(i=1; i<256; i++)
       {
          n[i] = 0;
          p[i] = 0;
       }
       for(i=0; i<height; i++)
       {
          for(j=0; j<width; j++)
          {
             s=cvGet2D(img, i, j);
             gray=s.val[0];
             n[gray]++;
          }
       }
       float u = 0;
       for(i=0; i<256; i++)
       {
          p[i] = n[i] / num;
          u = i * p[i] + u;
       }
       float w0=0, w1=0, u0=0, u1=0, tmp0=0, tmp1=0;
       float o2[256];

       for(k=1; k<256; k++)
       {
          w0=0;
          tmp0=0;
          for(i=1;i<=k;i++)
          {
             w0 += p[i];
             tmp0 = i * p[i] + tmp0;
          }
          if(w0 != 0)
             u0 = tmp0 / w0;
          else
             u0 = 0;
          w1=0;
          tmp1=0;
          for(i=k+1; i<256; i++)
          {
             w1+=p[i];
             tmp1 = i * p[i] +tmp1;
          }
          if (w1 != 0)
             u1 = tmp1 / w1;
          else
             u1 = 0;
             o2[k] = w0 * (u0 - u) * (u0 - u) + w1 * (u1 - u) * (u1 - u);
       }
       float max=0, threshold=0;

       for(i=1; i<256; i++)
       {
          if(o2[i]>max)
          {
             max = o2[i];
             threshold = i;
          }
          else
             continue;
       }

       CvScalar black = cvScalar(0, 0, 0);
       CvScalar white = cvScalar(255, 255, 255);

       for(i=0; i<height; i++)
       {
          for(j=0; j<width; j++)
          {
             s=cvGet2D(img, i, j);
             if(s.val[0] < (threshold-15))
                cvSet2D(img, i, j, black);
             else
                cvSet2D(img, i, j, white);
          }
       }
       return threshold;
}


int pvDetector::VideoStitch(const char* FileName)
{
    if(!FileName)
    {
        ShowMessage(QStringLiteral("There is no File......"));
        return -1;
    }
    if(cmdThreadStop==1)
    {
        return -1;
    }

    //提取图像信息
    CvCapture*Capture=cvCaptureFromAVI(FileName);
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);

    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );
    int FrameNum=TotalFrameCount;

    int EndPos=FrameNum;

    IplImage* Temp=cvQueryFrame(Capture);

    //算法参数
    const char* ConfigFileName="ProParam.rsc";
    ProParam* proParam=new ProParam;

    rsLoadProParam(ConfigFileName,proParam,&cvSize(Temp->width,Temp->height));

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    // 初始化 Res
    cvCopyImage(Temp,proMem->PreImage);
    cvCvtColor(proMem->PreImage, proMem->grayPre, CV_BGR2GRAY);


    proMem->DirectFlag=StartFlag;

    proMem->Res = rsInitRes(proParam,proMem->PreImage,proMem->Ho2r,StartFlag);
    proMem->Res = rsStitch(proParam,proMem);

    for(int i=BeginPos;i<EndPos;i+=FrameInterval)
    {
        if(cmdThreadStop==1)
        {
            emit ShowMessage(QStringLiteral("Stitching is Stopped......"));
            break;
        }
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,i);
        Temp=cvQueryFrame(Capture);

        // 拼接
        int PointsNum= rsUpdateStitching(Temp,proMem,proParam);

        // 显示
        ShowMessage(QStringLiteral("Finished: %1/%2").arg(i).arg(EndPos));
        cvCvtColor(proMem->CurrImage, proMem->CurrImage, CV_BGR2RGB);
        ShowImage(proMem->CurrImage);
    }

    cvSaveImage("StitchRes.jpg",proMem->Res);

    //撤销
    rsReleaseProMem(&proMem);
    cvReleaseCapture(&Capture);
    delete proParam;
    return 0;
}

int pvDetector::VideosDetect()
{
    if(cmdThreadStop==1)
    {
        return -1;
    }
    emit ShowMessage("VideosDetect Start......");
    for(int i=0;i<VideoNames.size();i++)
    {
        emit ShowMessage(QStringLiteral("%1 Video is Processing......").arg(i+1));
        SpotDetect(VideoNames[i].c_str(),i);
    }
}

int pvDetector:: SpotDetect(const char* FileName,int id)
{
    emit ShowMessage("SpotDetect() is Running......");
    //提取图像信息
    CvCapture*Capture=cvCaptureFromAVI(FileName);
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);

    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );
    int FrameNum=TotalFrameCount;

    int EndPos=FrameNum;

    IplImage* Temp=cvQueryFrame(Capture);

    //算法参数
    const char* ConfigFileName="ProParam.rsc";
    ProParam* proParam=new ProParam;

    rsLoadProParam(ConfigFileName,proParam,&cvSize(Temp->width,Temp->height));

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    // 初始化 Res
    cvCopyImage(Temp,proMem->PreImage);
    cvCvtColor(proMem->PreImage, proMem->grayPre, CV_BGR2GRAY);

    proMem->DirectFlag=StartFlag;

    proMem->Res = rsInitRes(proParam,proMem->PreImage,proMem->Ho2r,proMem->DirectFlag);
    proMem->Res = rsStitch(proParam,proMem);

    //绝对坐标系下的直线
    vector<int>SumXCoord;

    vector<HeatSpotParam> SumHeatSpotInfor;
    SumHeatSpotInfor.clear();

    for(int i=BeginPos;i<EndPos;i+=FrameInterval)
    {
        if(cmdThreadStop==1)
        {
            ShowMessage(QStringLiteral("Video%1 Spot Detect is Stopped......").arg(id+1));
            break;
        }
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,i);
        Temp=cvQueryFrame(Capture);

        //------ 拼接
        int PointsNum= rsUpdateStitching(Temp,proMem,proParam);

        //------ 直线检测
        vector<int> XCoord;
        XCoord.clear();

        vector<int> YCoord;
        YCoord.clear();

        rsGetXCoord(Temp,XCoord,proMem,proParam);
        rsGetYCoord(Temp,YCoord,proMem,proParam);

        UpdateXCoord(SumXCoord,XCoord,proMem);

        //------ 热斑检测
        vector<HeatSpotParam> HeatSpotInfor;
        HeatSpotInfor.clear();
        HeatSpotDetect(Temp,cvRect(0,0,proParam->ImageSize.width,proParam->ImageSize.height),HeatSpotInfor,&proParam->HeatConfig,id,i);

        GetGlobalCoord(HeatSpotInfor,proMem->Hn2r);
        GetSpotRow(HeatSpotInfor,YCoord);
        GetSpotCol(HeatSpotInfor,SumXCoord);

        //更新全局信息
        UpdateHeatSpotInfor(SumHeatSpotInfor,HeatSpotInfor);

        //------标注&显示
        rsDrawVertLines(proMem->CurrImage,XCoord);
        rsDrawHorLines(proMem->CurrImage,YCoord);
        for(int j=0;j<HeatSpotInfor.size();j++)
        {
            cvCircle(proMem->CurrImage,cvPoint(HeatSpotInfor[j].x,HeatSpotInfor[j].y),6,CV_RGB(0,255,0),2);
        }
        rsDrawRect(proMem->CurrImage,&proParam->VertRect,CV_RGB(128,0,0),2);
        rsDrawRect(proMem->CurrImage,&proParam->SpotRect,CV_RGB(255,0,0),3);

        cvCvtColor(proMem->CurrImage, proMem->CurrImage, CV_BGR2RGB);
        ShowImage(proMem->CurrImage);
    }

    // 更新总信息
    AddSoptInfor(TotalHeatSpotInfor,SumHeatSpotInfor);

    rsDrawVertLines(proMem->Res,SumXCoord);
    MarkResHeatSpot(proMem->Res,SumHeatSpotInfor,proParam);

    char outStr[20]={0};
    sprintf(outStr,"Res_%d.jpg",id+1);

    IplImage* Res=cvCloneImage(proMem->Res);
    ResImage.push_back(Res);
    cvSaveImage(outStr,proMem->Res);

    //撤销
    rsReleaseProMem(&proMem);
    cvReleaseCapture(&Capture);
    delete proParam;

    ShowMessage(QStringLiteral("Video%1 Spot Detect is Finished......").arg(id+1));

    return 0;
}

