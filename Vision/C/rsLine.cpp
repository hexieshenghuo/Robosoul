#include "rsLine.h"



int rsLsd(IplImage* Image,CvPoint2D64f * Lines,double Scale)
{
    int n;

    double* l=lsd_scale(&n,(double*)Image->imageData,Image->width,Image->height,Scale);
    for(int i=0;i<n;i++)
    {
        Lines[2*i+0].x=l[7*i+0];
        Lines[2*i+0].y=l[7*i+1];
        Lines[2*i+1].x=l[7*i+2];
        Lines[2*i+1].y=l[7*i+3];
    }
    if(l)
    {
        free((double*)l);
        l=0;
    }
    return n;
}

int rsForLsd(IplImage* Image,CvPoint2D64f * Lines)
{
    double scale=0.36;
    int N=0;
    for(int i=0;i<100;i++)
    {
        N=rsLsd(Image, Lines,scale);
        if(N>60)
        {
            break;
        }
        scale=MAX(0.0001,scale-i*0.05);
    }
    return N;
}

int rsDrawLine(IplImage* Image,CvPoint2D64d* Lines,int N,CvScalar Color)
{
    for(int i=0;i<N;i++)
    {
        cvLine(Image,cvPoint(Lines[2*i].x,Lines[2*i].y),
                cvPoint(Lines[2*i+1].x,Lines[2*i+1].y),Color,1);
    }
    return 0;
}

double rsSumPixel(IplImage* Image,CvRect SumRect,int isAverage)
{
    double Sum=0;
    for(int x=SumRect.x; x<SumRect.x+SumRect.width; x++)
    {
        for(int y=SumRect.y; y<SumRect.y+SumRect.height; y++)
        {
            Sum+=rsImage64D1(Image,x,y);
        }
    }

    return isAverage?(Sum/(SumRect.width*SumRect.height)):Sum;
}

int rsVertLinesDetect(IplImage* Image,vector<int>& XCoord,ProParam* proParam)
{
    int Step=proParam->VertShortStep;
    for(int x=proParam->VertRect.x;x<proParam->VertRect.x + proParam->VertRect.width;)
    {
        double Res=rsSumPixel(Image,cvRect(x,proParam->VertRect.y,proParam->VertWidth,proParam->VertRect.height),1);

        if(Res>proParam->VertThres)
        {
            //检测到直线
            Step=proParam->VertLongStep;
            XCoord.push_back(x+proParam->VertWidth/2);
        }
        else
        {
            //未检测到直线
            Step=proParam->VertShortStep;
        }

        x+=Step;

    }

    return XCoord.size();
}

int rsHorLinesDetect(IplImage* Image,vector<int>& YCoord,ProParam* proParam)
{
    int Step=proParam->HorShortStep;
    for(int y=proParam->HorRect.y;y<proParam->HorRect.y +proParam->HorRect.height;)
    {
        double Res=rsSumPixel(Image,cvRect(proParam->HorRect.x,y,proParam->HorRect.width,proParam->HorHeight),1);

        if(Res>proParam->HorThres)
        {
            //检测到直线
            Step=proParam->HorLongStep;
            YCoord.push_back(y+proParam->HorHeight/2);
        }
        else
        {
            //未检测到直线
            Step=proParam->HorShortStep;
        }
        y+=Step;
    }

    return YCoord.size();
}

int rsDrawVertLines(IplImage* Image,vector<int>& XCoord)
{
    for(int i=0;i<XCoord.size();i++)
    {
        cvLine(Image,cvPoint(XCoord[i],0),
               cvPoint(XCoord[i],Image->height-1),CV_RGB(0,255,0),2);
    }
    return 0;
}

int rsDrawHorLines(IplImage* Image,vector<int>& YCoord)
{
    for(int i=0;i<YCoord.size();i++)
    {
        cvLine(Image,cvPoint(0,YCoord[i]),
               cvPoint(Image->width-1,YCoord[i]),CV_RGB(0,255,0),2);
    }
    return 0;
}



int rsGetXCoord(IplImage* Image,vector<int>& XCoord,ProMem* proMem,ProParam* proParam)
{
    cvZero(proMem->LineGray);
    cvZero(proMem->LineImage);
    cvZero(proMem->LineImage64);
    cvZero(proMem->LineSum);
    cvZero(proMem->LineSum64);

    //图像预处理
    cvCopyImage(Image,proMem->LineImage);
    cvCvtColor(proMem->LineImage,proMem->LineGray,CV_BGR2GRAY);
    cvConvertScale(proMem->LineGray,proMem->LineSum64,1.0/255);

    int LsdNum=0;
    switch (proParam->VertMethod)
    {
    case 0:
        // Sobel
        cvSetImageROI(proMem->LineSum64,proParam->VertRect);
        cvSetImageROI(proMem->LineImage64,proParam->VertRect);
        cvSobel( proMem->LineSum64, proMem->LineImage64, proParam->xOrder,0,3);
        cvResetImageROI(proMem->LineImage64);
        cvResetImageROI(proMem->LineSum64);

#if (TESTING==1)
        cvShowImage("Image64",proMem->LineImage64);
        cvWaitKey(0);
#endif
        cvConvertScale(proMem->LineImage64,proMem->LineImage64,proParam->VertLsdGain);

        //Lsd直线提取
        LsdNum=rsLsd(proMem->LineImage64,proMem->Lines,proParam->VertLsdScale);
        //把Lsd的直线结果用白色画到一个黑色图像中以便统计
        rsDrawLine(proMem->LineSum,proMem->Lines,LsdNum,CV_RGB(255,255,255));
        cvCvtColor(proMem->LineSum,proMem->LineGray,CV_BGR2GRAY);
        cvConvertScale(proMem->LineGray,proMem->LineSum64,1.0/255);

        //直线坐标提取
        rsVertLinesDetect(proMem->LineSum64,XCoord,proParam);


#if(TESTING==1)
        rsDrawVertLines(proMem->LineImage,XCoord);
        rsDrawRect(proMem->LineSum,&proParam->VertRect,CV_RGB(255,0,0),1);
        cvShowImage("Sum",proMem->LineSum);

        cvShowImage("Image",proMem->LineImage);
        cvWaitKey(0);
#endif

        break;

    case 1:
        break;

    default:
        break;
    }

    return XCoord.size();
}


int rsGetYCoord(IplImage* Image,vector<int>& YCoord,ProMem* proMem,ProParam* proParam)
{
    cvZero(proMem->LineGray);
    cvZero(proMem->LineImage);
    cvZero(proMem->LineImage64);
    cvZero(proMem->LineSum);
    cvZero(proMem->LineSum64);

    //图像预处理
    cvCopyImage(Image,proMem->LineImage);
    cvCvtColor(proMem->LineImage,proMem->LineGray,CV_BGR2GRAY);
    cvConvertScale(proMem->LineGray,proMem->LineSum64,1.0/255);

    int LsdNum=0;
    switch (proParam->HorMethod)
    {
    case 0:
        // Sobel
        cvSetImageROI(proMem->LineSum64,proParam->HorRect);
        cvSetImageROI(proMem->LineImage64,proParam->HorRect);
        cvSobel( proMem->LineSum64, proMem->LineImage64, 0,proParam->yOrder,3);
        cvResetImageROI(proMem->LineImage64);
        cvResetImageROI(proMem->LineSum64);

#if (TESTING==1)
        cvShowImage("Image64",proMem->LineImage64);
        cvWaitKey(0);
#endif
        cvConvertScale(proMem->LineImage64,proMem->LineImage64,proParam->HorLsdGain);

        //Lsd
        LsdNum=rsLsd(proMem->LineImage64,proMem->Lines,proParam->HorLsdScale);
        //把Lsd的直线结果用白色画到一个黑色图像中以便统计
        rsDrawLine(proMem->LineSum,proMem->Lines,LsdNum,CV_RGB(255,255,255));
        cvCvtColor(proMem->LineSum,proMem->LineGray,CV_BGR2GRAY);
        cvConvertScale(proMem->LineGray,proMem->LineSum64,1.0/255);

        //直线坐标提取
        rsHorLinesDetect(proMem->LineSum64,YCoord,proParam);

#if(TESTING==1)
        rsDrawHorLines(proMem->LineImage,YCoord);
        rsDrawRect(proMem->LineSum,&proParam->HorRect,CV_RGB(255,0,0),1);
        cvShowImage("Sum",proMem->LineSum);
        cvShowImage("Image",proMem->LineImage);
        cvWaitKey(0);
#endif

        break;

    case 1:
        break;

    default:
        break;
    }

    return YCoord.size();
}


int HeatSpotDetect(IplImage* Image,CvRect ROI,vector<HeatSpotParam>& heatspotParam,HeatSpotConfig* heatspotConfig,int id,int Pos)
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

    cvErode(erzhiImg,img,0,(*heatspotConfig).EDnum);//腐蚀1
    cvDilate(img,erzhiImg,0,(*heatspotConfig).EDnum);//膨胀1
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
            if( i == (contoursTemp->total-1))
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
        if(contours)
        {
            cvClearSeq(contours);
            contours=0;
        }


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
int Otsu(IplImage* img)
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

int GetRow(int Y, vector<int> &YCoord)
{
    int Row=0;
    if (Y < YCoord[0])
    {
        return 0;
    }
    for(int i=0;i<3;i++)
    {
        if( Y >= YCoord[i] && Y < YCoord[i+1] )
        {
            Row=i+1;
            break;
        }
    }

    if(Y>=YCoord[3])
    {
        Row=4;
    }
    return Row;
}

int GetCol(int GlobalX, vector<int> &SumXCoord)
{
    int Col=0;
    for(int i=0;i<SumXCoord.size()-1;i++)
    {
        if( GlobalX >= SumXCoord[i] && GlobalX < SumXCoord[i+1] )
        {
            Col=i+1;
            break;
        }
    }

    if(GlobalX>=SumXCoord[SumXCoord.size()-1])
    {
        Col=SumXCoord.size();
    }

    return Col;

}

int GetSpotRow(vector<HeatSpotParam>& HeatSpotInfor,vector<int> &YCoord)
{
    for(int i=0;i<HeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=HeatSpotInfor[i];
        hsp.Row=GetRow(hsp.y, YCoord);
        HeatSpotInfor[i]=hsp;
    }
    return 0;
}

int AddSoptInfor(vector<HeatSpotParam>& SumHeatSpotInfor,vector<HeatSpotParam>& HeatSpotInfor)
{
    for(int i=0;i<HeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=HeatSpotInfor[i];
        SumHeatSpotInfor.push_back(hsp);
    }
    return 0;
}

int GetSpotCol(vector<HeatSpotParam>& SumHeatSpotInfor,vector<int> &SumXCoord)
{
    for(int i=0;i<SumHeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=SumHeatSpotInfor[i];
        hsp.Col=GetCol(hsp.GlobalX, SumXCoord);
        SumHeatSpotInfor[i]=hsp;
    }
    return 0;
}

int AddCoordX(vector<int>& SumXCoord,vector<int>& XCoord,ProMem* proMem)
{
    int Thres=30;
    for(int i=0;i<XCoord.size();i++)
    {
        if(SumXCoord.size()==0)
        {
            SumXCoord.push_back(XCoord[i]);
            continue;
        }

        int end=SumXCoord.size()-1;
        int X=XCoord[i] + (int)rsMat32F(proMem->Hn2r,0,2); //Global;
        if( (SumXCoord[end]+Thres )<= X)
        {
            SumXCoord.push_back(X);
        }
    }

    return 0;
}

#define ABS(X) ((X)>0?(X):(-X))

int GetMinNum(vector<int>& SumXCoord,int GlobalX,int* Dis)
{
    int MinDis=100000;
    int Num=0;
    for(int i=0;i< SumXCoord.size();i++)
    {
        int dis=abs(SumXCoord[i]-GlobalX);
        if(dis<=MinDis)
        {
            MinDis=dis;
            Dis[0]=dis;
            Num=i;
        }
    }
    return Num;
}

int UpdateXCoord(vector<int>& SumXCoord,vector<int>& XCoord,ProMem* proMem)
{
    float OffsetX=rsMat32F(proMem->Hn2r,0,2);
    int Thres= 36;

    for(int i=0;i<XCoord.size();i++)
    {
        int GlobalX=XCoord[i]+(int)OffsetX;
        int Dis=0;

        if(SumXCoord.size()==0)
        {
            SumXCoord.push_back(GlobalX);
            continue;
        }
        else
        {
            int Num=GetMinNum(SumXCoord, GlobalX,&Dis);
            if(Dis<=Thres)
            {
                //同一条线
                SumXCoord[Num]=GlobalX;
            }
            else
            {
                //新线
                SumXCoord.push_back(GlobalX);
            }
        }
    }

    return 0;
}


int GetGlobalCoord( vector<HeatSpotParam>& HeatSpotInfor,CvMat* H)
{
    for(int i=0;i<HeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=HeatSpotInfor[i];

        hsp.GlobalX= hsp.x + (int)rsMat32F(H,0,2);
        hsp.GlobalY= hsp.y + (int)rsMat32F(H,1,2);
        HeatSpotInfor[i]=hsp;

//        cout<<HeatSpotInfor[i].GlobalX<<" "<<HeatSpotInfor[i].GlobalY<<endl;
    }
    return 0;
}

int MarkResHeatSpot(IplImage* Res, vector<HeatSpotParam>& SumHeatSpotInfor,ProParam* proParam)
{
    CvFont font;
    cvInitFont(&font,CV_FONT_HERSHEY_COMPLEX,0.6,0.6,0,1,8);
//  cvInitFont(&font, CV_FONT_HERSHEY_COMPLEX, 0.5, 0.5, 1, 2, 8);
//    cvInitFont( &font, CV_FONT_VECTOR0,1, 1, 0, 7, 8);

    char S[100];

//cvPutText(pImg, "This is a picture named lena!", cvPoint(50, 50), &font, CV_RGB(255,0,0));
    for(int i=0;i<SumHeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=SumHeatSpotInfor[i];
        sprintf(S,"(%d,%d)",hsp.Row,hsp.Col);
        cvPutText(Res,S,cvPoint(hsp.GlobalX,hsp.GlobalY+proParam->OffsetY),&font,CV_RGB(1,25,88));
        cvCircle(Res,cvPoint(hsp.GlobalX,hsp.GlobalY+proParam->OffsetY),6,CV_RGB(0,200,0),2);
    }
    return 0;
}

int UpdateHeatSpotInfor(vector<HeatSpotParam>& SumHeatSpotInfor,vector<HeatSpotParam>& HeatSpotInfor)
{
    if(SumHeatSpotInfor.size()==0 && HeatSpotInfor.size()>0)
    {
        SumHeatSpotInfor.push_back(HeatSpotInfor[0]);
    }

    for(int i=0;i<HeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp = HeatSpotInfor[i];
        int Haven=0;
        for(int j=0;j<SumHeatSpotInfor.size();j++)
        {
            HeatSpotParam sumhsp=SumHeatSpotInfor[j];
            if( (hsp.Col==sumhsp.Col) && (hsp.Row==sumhsp.Row ) )
            {
                SumHeatSpotInfor[j]=hsp;
                Haven=1;
                break;
            }
        }
        if(!Haven)
        {
            SumHeatSpotInfor.push_back(hsp);
        }
    }

    return 0;
}
