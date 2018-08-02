#include <BasicOperation.h>
#include <FileOper.h>
//#include <imagestitch.h>
#include <iostream>
#include <strstream>
#include <string>
#include <math.h>

using namespace std;
using namespace cv;


#define Test1     (1)   // 角点
#define Test2     (2)   // 参数
#define Test3     (3)   // 参数化 Harris Sub
#define Test5     (5)   // L-K
#define Test6     (6)   // 几何变换
#define Test7     (7)   // Homography
#define Test8     (8)   // 图像拼接操作
#define Test9     (9)   // Homography 拼接
#define Test10    (10)  // 连续匹配
#define Test12    (12)  // Video路径名字
#define Test15    (15)  //
#define Test16    (16)  // 用Mem封装Test10
#define Test17    (17)  // 对Test16的函数封装以为线程准备
#define Test18    (18)  // 垂直直线检测
#define Test19    (19)  // LSD源码测试
#define Test20    (20)  // 垂直与水平直线检测
#define Test21    (21)  // 综合测试
#define Test22    (22)  // 基本代码测试


#define Running   Test21

#if (Running==Test1)

enum Params
{
    PointMaxNum=1258
};

int main()
{
    //参数

    CvTermCriteria SubTerm=cvTermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS,20,0.03);
    int SubSize=10;

    int FramePos_1=128;
    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    cout<<Width<<endl;
    cout<<Height<<endl;

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_1);


    IplImage* Image_1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    IplImage* temp=cvQueryFrame(Capture);
    IplImage* grayImage = cvCreateImage(cvSize(Image_1->width,Image_1->height), IPL_DEPTH_8U,1);

    cvCopyImage(temp,Image_1);
    cvCvtColor(Image_1, grayImage, CV_BGR2GRAY);

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proparam=new ProParam;
    rsLoadProParam(FileName,proparam);


    CvPoint2D32f* Points=new CvPoint2D32f[PointMaxNum];
    CvPoint2D32f* Points2=new CvPoint2D32f[PointMaxNum];

    //创建连个与原图大小相同的临时图像
    IplImage* Temp1=0;// cvCreateImage(cvSize(grayImage->width,grayImage->height), IPL_DEPTH_32F, 1);
    IplImage* Temp2=0;// cvCreateImage(cvSize(grayImage->width,grayImage->height), IPL_DEPTH_32F, 1);
    CvMat* Mask=0;// rsGetMaskFromROI(cvSize(grayImage->width,grayImage->height),HarrisROI[0]);

    rsInitCornerParam(cvGetSize(grayImage),proparam->HarrisROI,&Temp1,&Temp2,&Mask);
    int CornerCount=rsCorners(grayImage,Points,Mask,Temp1,Temp2,proparam);

    rsDrawPoints(Image_1,Points,CornerCount,3,CIRCLE,CV_RGB(0,255,0));
    rsDrawRect(Image_1,&proparam->HarrisROI,CV_RGB(0,255,0));

    cout<<CornerCount<<endl;

    cvNamedWindow("Show");
    cvShowImage("Show",Image_1);
    cvWaitKey(0);

    if(Points)
    {
        delete[] Points;
        Points=0;
    }

    if(Image_1)
    {
        cvReleaseImage(&Image_1);
    }

    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }
}

#elif (Running==Test2)

int main()
{
    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proparam=new ProParam;
    rsLoadProParam(FileName,proparam);

    cout<<"QualityLevel: "<<proparam->QualityLevel<<endl;
    cout<<"MinDis: "<<proparam->MinDis<<endl;
    cout<<"BlockSize: "<<proparam->BlockSize<<endl;
    cout<<"K: "<<proparam->K<<endl;
    cout<<"UseHarris: "<<proparam->UseHarris<<endl;
    cout<<"HarrisROI: "<<proparam->HarrisROI.x<<" "<<proparam->HarrisROI.y<<" "<<proparam->HarrisROI.width<<" "<<proparam->HarrisROI.height<<endl;
    cout<<"PointMaxNum: "<<proparam->PointMaxNum<<endl;
    cout<<"SubTerm: "<<proparam->SubTerm.type<<" "<<proparam->SubTerm.max_iter<<" "<<proparam->SubTerm.epsilon<<endl;
    cout<<"SubSize: "<<proparam->SubSize<<endl;
    cout<<"LKSize: "<<proparam->LKSize<<endl;
    cout<<"LKLevel: "<<proparam->LKLevel<<endl;
    cout<<"LKTerm: "<<proparam->LKTerm.type<<" "<<proparam->LKTerm.max_iter<<" "<<proparam->LKTerm.epsilon<<endl;
    cout<<"LKFlag: "<<proparam->LKFlag<<endl;
    cout<<"HomoMethod: "<<proparam->HomoMethod<<endl;
    cout<<"ransacThres: "<<proparam->ransacThres<<endl;
    cout<<"ResSize : "<<proparam->ResSize.width<<" "<<proparam->ResSize.height<<endl;
    cout<<"StitchROI: "<<proparam->StitchROI.x<<" "<<proparam->StitchROI.y<<" "<<proparam->StitchROI.width<<" "<<proparam->StitchROI.height<<endl;
    return 0;
}

#elif (Running==Test3)
int main()
{
    int FramePos_1=158;
    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_1);

    IplImage* Image_1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    IplImage* temp=cvQueryFrame(Capture);
    IplImage* grayImage = cvCreateImage(cvSize(Image_1->width,Image_1->height), IPL_DEPTH_8U,1);

    cvCopyImage(temp,Image_1);
    cvCvtColor(Image_1, grayImage, CV_BGR2GRAY);

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proparam=new ProParam;
    ProMem* proMem=new ProMem;
    CvSize size=cvGetSize(Image_1);
    rsLoadProParam(FileName,proparam,&size);
    rsInitProMem(proparam,proMem);

    CvPoint2D32f* Points=new CvPoint2D32f[proparam->PointMaxNum];

    int CornerCount=rsCorners(grayImage,Points,proMem,proparam);

    rsDrawPoints(Image_1,Points,CornerCount,3,CIRCLE,CV_RGB(0,255,0));
    rsDrawRect(Image_1,&proparam->HarrisROI,CV_RGB(0,255,0));

    cout<<CornerCount<<endl;

    cvNamedWindow("Show");
    cvShowImage("Show",Image_1);

    rsSubPixel(grayImage,Points,CornerCount,proparam);
    rsDrawPoints(Image_1,Points,CornerCount,3,CIRCLE,CV_RGB(0,0,255));

    cvNamedWindow("Show2");
    cvShowImage("Show2",Image_1);

    cvWaitKey(0);

    if(Points)
    {
        delete[] Points;
        Points=0;
    }

    if(Image_1)
    {
        cvReleaseImage(&Image_1);
    }

    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }

    rsReleaseProMem(&proMem);

    return 0;
}

#elif (Running==Test5)

int main()
{
    int FrameInterval=1;
    int FramePos_1=263;
    int FramePos_2=FramePos_1+FrameInterval;
    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    IplImage* Image_1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* Image_2=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    IplImage* grayImage_1 = cvCreateImage(cvSize(Image_1->width,Image_1->height), IPL_DEPTH_8U,1);
    IplImage* grayImage_2 = cvCreateImage(cvSize(Image_1->width,Image_1->height), IPL_DEPTH_8U,1);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_1);
    IplImage* temp=cvQueryFrame(Capture);

    cvCopyImage(temp,Image_1);
    cvCvtColor(Image_1, grayImage_1, CV_BGR2GRAY);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_2);
    temp=cvQueryFrame(Capture);

    cvCopyImage(temp,Image_2);
    cvCvtColor(Image_2, grayImage_2, CV_BGR2GRAY);

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proparam=new ProParam;
    ProMem* proMem=new ProMem;
    CvSize size=cvGetSize(Image_1);
    rsLoadProParam(FileName,proparam,&size);
    rsInitProMem(proparam,proMem);

    CvPoint2D32f* Points1=new CvPoint2D32f[proparam->PointMaxNum];
    CvPoint2D32f* Points2=new CvPoint2D32f[proparam->PointMaxNum];

    int CornerCount=rsCorners(grayImage_1,Points1,proMem,proparam);
    rsSubPixel(grayImage_1,Points1,CornerCount,proparam);

    cout<<CornerCount<<endl;

    rsLK(grayImage_1,grayImage_2,Points1,Points2,CornerCount,proMem,proparam);

//  rsSubPixel(grayImage_2,Points2,CornerCount,proparam);

    rsDisplayPoints(Points1,Points2,CornerCount,1);

    rsDrawRect(Image_1,&proparam->HarrisROI,CV_RGB(0,255,0));

    rsDrawPoints(Image_1,Points1,CornerCount,2,1,CV_RGB(0,255,0));
    rsDrawPoints(Image_2,Points2,CornerCount,2,1,CV_RGB(0,255,0));
    rsDrawPoints(Image_2,Points1,CornerCount,2,1,CV_RGB(0,0,255));

    cvShowImage("Image1",Image_1);
    cvShowImage("Image2",Image_2);

    cvWaitKey(0);

    if(Points1)
    {
        delete[] Points1;
        Points1=0;
    }

    if(Points2)
    {
        delete[] Points2;
        Points2=0;
    }

    if(Image_1)
    {
        cvReleaseImage(&Image_1);
    }

    if(Image_2)
    {
        cvReleaseImage(&Image_1);
    }


    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }

    rsReleaseProMem(proMem);

    return 0;
}

#elif (Running==Test6)
int main()
{

    int FramePos_1=263;

    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    IplImage* Image_1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* Image_2=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_1);
    IplImage* temp=cvQueryFrame(Capture);

    cvCopyImage(temp,Image_1);

    //
    CvMat* H=cvCreateMat(3,3,CV_32FC1);
    float Angle=CV_PI/6*1;
    float c=cos(Angle);
    float s=sin(Angle);
    float dx=0,dy=00;
    float sx=0.0, sy=0.0;
    float data[9]={c,-s,dx,s,c,dy,sx,sy,1};
    cvSetData(H,data,sizeof(float)*3);

    cvWarpPerspective(Image_1,Image_2,H,
                      CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,cvScalarAll(255));

    cvShowImage("Image1",Image_1);
    cvShowImage("Homography",Image_2);

    cvWaitKey(0);
    return 0;
}

#elif (Running==Test7)
int main()
{
    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proparam=new ProParam;
    rsLoadProParam(FileName,proparam);
    float dx=2.58;
    float dy=1.88;

    int Num=6;
    CvPoint2D32f* Ps1=new CvPoint2D32f[Num];
    CvPoint2D32f* Ps2=new CvPoint2D32f[Num];

    Ps1[0].x=1;Ps1[0].y=2;
    Ps1[1].x=3;Ps1[1].y=9;
    Ps1[2].x=12;Ps1[2].y=12;
    Ps1[3].x=36;Ps1[3].y=58;
    Ps1[4].x=66;Ps1[4].y=128;
    Ps1[5].x=9;Ps1[5].y=8;

    for(int i=0;i<Num;i++)
    {
        Ps2[i].x=Ps1[i].x+dx;
        Ps2[i].y=Ps1[i].y+dy;
    }

    CvMat* H=cvCreateMat(3,3,CV_32FC1);
    rsGetH(Ps1,Ps2,Num,H,proparam);

    rsSimpleH(H);
    rsDisplayH(H);

    return 0;
}

#elif (Running==Test8)
int main()
{
    int FrameInterval=18;
    int FramePos_1=263;
    int FramePos_2=FramePos_1+FrameInterval;

    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_00.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    IplImage* Image_1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* Image_2=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_1);
    IplImage* temp=cvQueryFrame(Capture);
    cvCopyImage(temp,Image_1);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,FramePos_2);
    temp=cvQueryFrame(Capture);
    cvCopyImage(temp,Image_2);

    CvMat* H=cvCreateMat(3,3,CV_32FC1);
    float dx=16;
    float dy=0;
    float d[9]={1,0,dx,
                0,1,dy,
                0,0,1};

    cvSetData(H,d,sizeof(float)*3);

    IplImage* Res=0;

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam);

    Res=rsStitch(Image_1,Image_2,H,Res,proParam);


    cvShowImage("Res",Res);


    cvWaitKey(0);

    cvReleaseImage(&Image_1);
    cvReleaseImage(&Image_2);
    cvReleaseImage(&Res);

    cvReleaseMat(&H);

    cvReleaseCapture(&Capture);
    return 0;
}

#elif (Running==Test9)

int main()
{
    CvMat* Ho2r=cvCreateMat(3,3,CV_32FC1);// old to Res
    CvMat* Hn2o=cvCreateMat(3,3,CV_32FC1);// new to old
    CvMat* Hn2r=cvCreateMat(3,3,CV_32FC1);// new to Res

    rsUnitMat(Ho2r);
    rsUnitMat(Hn2o);
    rsUnitMat(Hn2r);

    int FrameInterval=3; // 图像间隔
    int Pos1=158;
    int Pos2=Pos1 + FrameInterval;
    int Pos3=Pos2 + FrameInterval;

    CvCapture*Capture=cvCaptureFromAVI( "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam,&(cvSize(Width,Height)) );

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    IplImage* Image1=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* Image2=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* Image3=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    IplImage* gray1 = cvCreateImage(cvSize(Image1->width,Image1->height), IPL_DEPTH_8U,1);
    IplImage* gray2 = cvCreateImage(cvSize(Image1->width,Image1->height), IPL_DEPTH_8U,1);
    IplImage* gray3 = cvCreateImage(cvSize(Image1->width,Image1->height), IPL_DEPTH_8U,1);


    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,Pos1);
    IplImage* temp=cvQueryFrame(Capture);
    cvCopyImage(temp,Image1);
    cvCvtColor(Image1, gray1, CV_BGR2GRAY);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,Pos2);
    temp=cvQueryFrame(Capture);
    cvCopyImage(temp,Image2);
    cvCvtColor(Image2, gray2, CV_BGR2GRAY);

    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,Pos3);
    temp=cvQueryFrame(Capture);
    cvCopyImage(temp,Image3);
    cvCvtColor(Image3, gray3, CV_BGR2GRAY);

    CvPoint2D32f* Ps1=new CvPoint2D32f[proParam->PointMaxNum];
    CvPoint2D32f* Ps2=new CvPoint2D32f[proParam->PointMaxNum];
    CvPoint2D32f* Ps3=new CvPoint2D32f[proParam->PointMaxNum];

    // 初始化Res
    IplImage* Res = rsInitRes(proParam,Image1,Ho2r);
    Res=rsStitch(Res,Image1,Ho2r,Res,proParam,proMem);

    //------1-2
    //角点
    int PointsNum=rsCorners(gray1,Ps1,proMem,proParam);
    rsSubPixel(gray1,Ps1,PointsNum,proParam);



    rsDrawPoints(Image1,Ps1,PointsNum,3,1,CV_RGB(0,255,0));
    rsDrawRect(Image1,&proParam->HarrisROI,CV_RGB(0,0,255));

    // LK
    rsLK(gray1,gray2,Ps1,Ps2,PointsNum,proMem,proParam);
    // rsDrawPoints(Image2,Ps1,PointsNum,3,1,CV_RGB(0,255,0));
    rsDrawRect(Image2,&proParam->HarrisROI,CV_RGB(0,0,255));

    rsSubPixel(gray2,Ps2,PointsNum,proParam);
    // Homography
    rsGetH(Ps2,Ps1,PointsNum,Hn2o,proParam);
    rsDisplayH(Hn2o);

    // Stiching
    rsMultiMat(Hn2o,Ho2r,Hn2r);

    Res=rsStitch(Res,Image2,Hn2r,Res,proParam);
    cvShowImage("Res",Res);

    //------2-3
    CvMat* Temp=0;
    CV_SWAP(Ho2r,Hn2o,Temp);

    PointsNum=rsCorners(gray2,Ps1,proMem,proParam);
    rsSubPixel(gray2,Ps1,PointsNum,proParam);

    rsDrawPoints(Image2,Ps2,PointsNum,3,1,CV_RGB(0,255,0));

    // LK
    rsLK(gray2,gray3,Ps1,Ps2,PointsNum,proMem,proParam);
    rsDrawPoints(Image3,Ps1,PointsNum,3,1,CV_RGB(0,255,0));
    rsDrawRect(Image3,&proParam->HarrisROI,CV_RGB(0,0,255));


    // Homography
    rsGetH(Ps2,Ps1,PointsNum,Hn2o,proParam);
    rsDisplayH(Hn2o);

    // Stiching
    rsMultiMat(Hn2o,Ho2r,Hn2r);

    Res=rsStitch(Res,Image3,Hn2r,Res,proParam);
//    cvShowImage("Res3",Res);

    cvShowImage("Image1",Image1);
    cvShowImage("Image2",Image2);
//    cvShowImage("Image3",Image3);


    cvWaitKey(0);

    cvReleaseImage(&Image1);
    cvReleaseImage(&Image2);
    cvReleaseImage(&Image3);

    cvReleaseImage(&gray1);
    cvReleaseImage(&gray2);
    cvReleaseImage(&gray3);

    cvReleaseImage(&Res);


    rsReleaseProMem(&proMem);

    delete[] Ps1;
    delete[] Ps2;

    return 0;
}
#elif(Running==Test10)
    int main()
    {

    rsStartTime(Time);

        CvMat* Ho2r=cvCreateMat(3,3,CV_32FC1);// old to Res
        CvMat* Hn2o=cvCreateMat(3,3,CV_32FC1);// new to old
        CvMat* Hn2r=cvCreateMat(3,3,CV_32FC1);// new to Res

        rsUnitMat(Ho2r);
        rsUnitMat(Hn2o);
        rsUnitMat(Hn2r);

        int FrameInterval=1; // 图像间隔
        int BeginPos=128;
        int FrameNum=600;

        CvCapture*Capture=cvCaptureFromAVI("F:/2017_00.mp4");// "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
        int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
        int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);
        int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );

        cout<<"TotalFrameCount: "<<TotalFrameCount<<endl;

        const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
        ProParam* proParam=new ProParam;
        rsLoadProParam(FileName,proParam,&(cvSize(Width,Height)) );

        ProMem* proMem=new ProMem;
        rsInitProMem(proParam,proMem);

        CvPoint2D32f* Ps1=new CvPoint2D32f[proParam->PointMaxNum];
        CvPoint2D32f* Ps2=new CvPoint2D32f[proParam->PointMaxNum];
        CvPoint2D32f* Ps3=new CvPoint2D32f[proParam->PointMaxNum];

        // 图像
        IplImage* PreImage=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
        IplImage* CurrImage=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

        IplImage* grayPre = cvCreateImage(cvSize(PreImage->width,PreImage->height), IPL_DEPTH_8U,1);
        IplImage* grayCurr = cvCreateImage(cvSize(PreImage->width,PreImage->height), IPL_DEPTH_8U,1);

        IplImage* Temp=0;

        // 初始化 Res
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);
        Temp=cvQueryFrame(Capture);
        cvCopyImage(Temp,PreImage);
        cvCvtColor(PreImage, grayPre, CV_BGR2GRAY);

        IplImage* Res = rsInitRes(proParam,PreImage,Ho2r);
        Res=rsStitch(Res,PreImage,Ho2r,Res,proParam,proMem);

        cout<<"Res->width: "<<Res->width<<endl;

        // 拼接循环
        for(int i=0;i<MAX(1,FrameNum);i++)
        {
            cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos+(i)*FrameInterval);
            Temp=cvQueryFrame(Capture);
            cvCopyImage(Temp,CurrImage);
            cvCvtColor(CurrImage, grayCurr, CV_BGR2GRAY);

            // Corner
            int PointsNum=rsCorners(grayPre,Ps1,proMem,proParam);
            rsSubPixel(grayPre,Ps1,PointsNum,proParam);

            cout<<PointsNum<<endl;

            // L-K
            rsLK(grayPre,grayCurr,Ps1,Ps2,PointsNum,proMem,proParam);
            rsSubPixel(grayCurr,Ps2,PointsNum,proParam);

            // Homography
            rsPsTrans(Ps1,Ps3,PointsNum,Ho2r);
            rsGetH(Ps2,Ps3,PointsNum,Hn2r,proParam);

            // 化简
            rsSimpleH(Hn2r);

            //拼接
            Res=rsStitch(Res,CurrImage,Hn2r,Res,proParam,proMem);

            //控制台显示 矩阵
            rsDisplayH(Hn2r);
            cout<<endl<<endl;

            // Upate
            CvMat* tempH=0;
            IplImage* TempImage=0;

            CV_SWAP(Hn2r,Ho2r,tempH);
            CV_SWAP(grayCurr,grayPre,TempImage);

            // Show
            rsDrawRect(CurrImage,&proParam->HarrisROI,CV_RGB(0,255,0));
            rsDrawPoints(CurrImage,Ps2,PointsNum,3,1,CV_RGB(0,255,0));
            cvShowImage("Curr",CurrImage);
            cvShowImage("Res",Res);
            cvWaitKey(18);

        }

        cvSaveImage("Res.jpg",Res);
        Time=rsGetTime(Time);

        cout<<"Time: "<<Time<<endl;

        // Show
        cvShowImage("Res",Res);
        cvWaitKey(0);


        cvReleaseImage(&PreImage);
        cvReleaseImage(&CurrImage);
        cvReleaseImage(&grayPre);
        cvReleaseImage(&grayCurr);
        cvReleaseImage(&Res);

        delete[] Ps1;
        delete[] Ps2;
        delete[] Ps3;

        delete proParam;
        rsReleaseProMem(&proMem);
        cvReleaseCapture(&Capture);
        Capture=0;

        return 0;
    }


#elif (Running==Test12)

#include<iostream>
#include<vector>
#include<io.h>
#include<string>

using namespace std;

int rsGetVideoNamesFromPath(const char* Path,vector<string> &VideoNames)
{
    VideoNames.clear();
    struct _finddata_t c_file;
    long handle_File;

    string FilePath=Path;
    FilePath+="\\*.avi";

    if( (handle_File = _findfirst( FilePath.c_str(), &c_file )) == -1L)
    {
        return -1;
    }
    else
    {
        string FileName=Path;
        FileName+="\\";
        FileName+=+c_file.name;
        VideoNames.push_back(FileName);
        while( _findnext( handle_File, &c_file ) == 0 )
        {

            string FileName=Path;
            FileName+="\\";
            FileName+=+c_file.name;
            VideoNames.push_back(FileName);
        }
    }
    _findclose( handle_File );
    return 0;
}
int main()
{
  const char* path="F:";
  vector<string> VideoNames;
  rsGetVideoNamesFromPath(path,VideoNames);

  for(int i=0;i<VideoNames.size();i++)
  {
      cout<<VideoNames[i]<<endl;
  }
  return 0;
}

#elif(Running==Test16)

#include <imagestitch.h>

int main()
{

rsStartTime(Time);

    int FrameInterval=1; // 图像间隔
    int BeginPos=3;


    CvCapture*Capture=cvCaptureFromAVI("F:/DJI_0005.mp4");//"F:/DJI_0001.mp4";//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);
    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );

    int FrameNum=TotalFrameCount;
    cout<<"TotalFrameCount: "<<TotalFrameCount<<endl;

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam,&(cvSize(Width,Height)) );

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    IplImage* Temp=0;

    // 初始化 Res
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);
    Temp=cvQueryFrame(Capture);
    cvCopyImage(Temp,proMem->PreImage);
    cvCvtColor(proMem->PreImage, proMem->grayPre, CV_BGR2GRAY);

    int DirectFlag=1;
    proMem->DirectFlag=DirectFlag;

    proMem->Res = rsInitRes(proParam,proMem->PreImage,proMem->Ho2r,DirectFlag);
    proMem->Res = rsStitch(proParam,proMem);

    // 拼接循环
    for(int i=BeginPos;i<MAX(6,FrameNum);i+=FrameInterval)
    {
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,i);
        Temp=cvQueryFrame(Capture);

        int PointsNum= rsUpdateStitching(Temp,proMem,proParam);

        // Show
        rsDrawPoints(proMem->CurrImage,proMem->Ps2,PointsNum,3,1,CV_RGB(0,255,0));
        cvShowImage("Curr",proMem->CurrImage);
        cvShowImage("Res",proMem->Res);
        cvWaitKey(9);

        cout<<"i:"<<i<<endl;

    }

Time=rsGetTime(Time);

    cout<<"Time: "<<Time<<endl;

    // Show
    cvShowImage("Res",proMem->Res);
    cvWaitKey(0);

    delete proParam;
    rsReleaseProMem(&proMem);
    cvReleaseCapture(&Capture);
    Capture=0;

    return 0;
}

#elif(Running==Test17)


int main()
{

rsStartTime(Time);

    int FrameInterval=3; // 图像间隔
    int BeginPos=0;
    int FrameNum=600;

    CvCapture*Capture=cvCaptureFromAVI("F:/2017_01.mp4");// "F:/2017_01.mp4" );//"F:/2017.avi" //读取视频
    int Width=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_WIDTH);
    int Height=(int)cvGetCaptureProperty(Capture,CV_CAP_PROP_FRAME_HEIGHT);
    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );

    cout<<"TotalFrameCount: "<<TotalFrameCount<<endl;

    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam,&(cvSize(Width,Height)) );

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    IplImage* Temp=0;

    // 初始化 Res
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);
    Temp=cvQueryFrame(Capture);
    cvCopyImage(Temp,proMem->PreImage);
    cvCvtColor(proMem->PreImage, proMem->grayPre, CV_BGR2GRAY);

    proMem->Res = rsInitRes(proParam,proMem->PreImage,proMem->Ho2r);
    proMem->Res = rsStitch(proParam,proMem);

    cout<<"Res->width: "<<proMem->Res->width<<endl;

    // 拼接循环
    for(int i=0;i<MAX(1,FrameNum);i++)
    {
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos+(i)*FrameInterval);
        Temp=cvQueryFrame(Capture);
        cvCopyImage(Temp,proMem->CurrImage);
        cvCvtColor(proMem->CurrImage, proMem->grayCurr, CV_BGR2GRAY);

        // Corner
        int PointsNum=rsCorners(proMem->grayPre,proMem->Ps1,proMem,proParam);
        rsSubPixel(proMem->grayPre,proMem->Ps1,PointsNum,proParam);

        cout<<PointsNum<<endl;

        // L-K
        rsLK(proMem->grayPre,proMem->grayCurr,proMem->Ps1,proMem->Ps2,PointsNum,proMem,proParam);
        rsSubPixel(proMem->grayCurr,proMem->Ps2,PointsNum,proParam);

        // Homography
        rsPsTrans(proMem->Ps1,proMem->Ps3,PointsNum,proMem->Ho2r);
        rsGetH(proMem->Ps2,proMem->Ps3,PointsNum,proMem->Hn2r,proParam);

        // 化简
        rsSimpleH(proMem->Hn2r);

        //拼接
        proMem->Res=rsStitch(proMem->Res,proMem->CurrImage,proMem->Hn2r,proMem->Res,proParam,proMem);

        //控制台显示 矩阵
        rsDisplayH(proMem->Hn2r);
        cout<<endl<<endl;

        // Upate
        CvMat* tempH=0;
        IplImage* TempImage=0;

        CV_SWAP(proMem->Hn2r,proMem->Ho2r,tempH);
        CV_SWAP(proMem->grayCurr,proMem->grayPre,TempImage);

        // Show
        rsDrawRect(proMem->CurrImage,&proParam->HarrisROI,CV_RGB(0,255,0));
        rsDrawPoints(proMem->CurrImage,proMem->Ps2,PointsNum,3,1,CV_RGB(0,255,0));
        cvShowImage("Curr",proMem->CurrImage);
        cvShowImage("Res",proMem->Res);
        cvWaitKey(18);

    }

    cvSaveImage("Res.jpg",proMem->Res);
Time=rsGetTime(Time);

    cout<<"Time: "<<Time<<endl;

    // Show
    cvShowImage("Res",proMem->Res);
    cvWaitKey(0);

    delete proParam;
    rsReleaseProMem(proMem);
    cvReleaseCapture(&Capture);
    Capture=0;

    return 0;
}

#elif(Running==Test18)

#include<rsLine.h>

int main()
{
    int BeginPos=3;

    //提取图像
    CvCapture*Capture=cvCaptureFromAVI("F:/2017_01.mp4");
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);
    IplImage* Temp=cvQueryFrame(Capture);


    //算法参数
    const char* FileName="F:/RoboSoul/Project/ImagesStitching/ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam);
    proParam->ImageSize=cvSize(Temp->width,Temp->height);

    cout<<proParam->VertShortStep<<endl;
    cout<<proParam->VertLongStep<<endl;
    cout<<proParam->VertWidth<<endl;
    cout<<proParam->VertHeight<<endl;
    cout<<proParam->VertRect.x<<" "<<proParam->VertRect.y<<" "<<proParam->VertRect.width<<" "<<proParam->VertRect.height<<endl;
    cout<<proParam->VertThres<<endl;
    cout<<proParam->xOrder<<endl;
    cout<<proParam->VertLsdScale<<endl;
    cout<<proParam->VertLsdGain<<endl;
    cout<<proParam->VertMethod<<endl;

    cout<<proParam->HorShortStep<<endl;
    cout<<proParam->HorLongStep<<endl;
    cout<<proParam->HorWidth<<endl;
    cout<<proParam->HorHeight<<endl;
    cout<<proParam->HorRect.x<<" "<<proParam->HorRect.y<<" "<<proParam->HorRect.width<<" "<<proParam->HorRect.height<<endl;
    cout<<proParam->HorThres<<endl;
    cout<<proParam->yOrder<<endl;
    cout<<proParam->HorLsdScale<<endl;
    cout<<proParam->HorLsdGain<<endl;
    cout<<proParam->HorMethod<<endl;


    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    vector<int> XCoord;
    XCoord.clear();


    rsGetXCoord(Temp,XCoord,proMem,proParam);

    //撤销
    rsReleaseProMem(&proMem);

    return 0;
}

#elif(Running==Test19)
#include <stdio.h>
#include <stdlib.h>
#include "lsd.h"

int main(void)
{
  double * image;
  double * out;
  int x,y,i,j,n;
  int X = 128;  /* x image size */
  int Y = 128;  /* y image size */

  /* create a simple image: left half black, right half gray */
  image = (double *) malloc( X * Y * sizeof(double) );
  if( image == NULL )
    {
      fprintf(stderr,"error: not enough memory\n");
      exit(EXIT_FAILURE);
    }
  for(x=0;x<X;x++)
    for(y=0;y<Y;y++)
      image[x+y*X] = x<X/2 ? 0.0 : 64.0; /* image(x,y) */


  /* LSD call */
  out = lsd(&n,image,X,Y);


  /* print output */
  printf("%d line segments found:\n",n);
  for(i=0;i<n;i++)
    {
      for(j=0;j<7;j++)
        printf("%f ",out[7*i+j]);
      printf("\n");
    }

  /* free memory */
  free( (void *) image );
  free( (void *) out );

  return EXIT_SUCCESS;
}

#elif(Running==Test20)

#include<rsLine.h>

#define TESTING (1)

int main()
{
    int BeginPos=3;

    //提取图像
    CvCapture*Capture=cvCaptureFromAVI("F:/2017_01.mp4");
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);

    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );
    int FrameNum=TotalFrameCount;


    IplImage* Temp=cvQueryFrame(Capture);

    //算法参数
    const char* FileName="ProParam.rsc";
    ProParam* proParam=new ProParam;
    rsLoadProParam(FileName,proParam);
    proParam->ImageSize=cvSize(Temp->width,Temp->height);

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

    for(int i=BeginPos;i<MAX(BeginPos+1,FrameNum);i+=3)
    {
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,i);
        Temp=cvQueryFrame(Capture);


    vector<int> XCoord;
    XCoord.clear();

    vector<int> YCoord;
    YCoord.clear();

    rsGetXCoord(Temp,XCoord,proMem,proParam);
    rsGetYCoord(Temp,YCoord,proMem,proParam);


    rsDrawVertLines(Temp,XCoord);
    rsDrawHorLines(Temp,YCoord);

//    rsDrawRect(Temp,&proParam->VertRect,CV_RGB(255,0,0),2);
//    rsDrawRect(Temp,&proParam->HorRect,CV_RGB(0,0,255),2);


   cvShowImage("Image",Temp);

//    cvSaveImage("Image.jpg",Temp);
    cvWaitKey(10);
    cout<<"i"<<i<<endl;

    }

    cout<<"OK"<<endl;
    //撤销
    rsReleaseProMem(&proMem);

    return 0;
}

#elif(Running==Test21)

#include<rsLine.h>
#if (0)
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

cout<<HeatSpotInfor[i].GlobalX<<" "<<HeatSpotInfor[i].GlobalY<<endl;
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

#endif


//Very Important!!!!!! DO NOT Delete!!!
int rsVideoDetect(const char* FileName,int BeginPos=3,int Interval=1)
{
    //提取图像信息
    CvCapture*Capture=cvCaptureFromAVI(FileName);
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,BeginPos);

    int TotalFrameCount=cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_COUNT );
    int FrameNum=TotalFrameCount;

    int EndPos=FrameNum/1;

    IplImage* Temp=cvQueryFrame(Capture);

    //算法参数
    const char* ConfigFileName="ProParam.rsc";
    ProParam* proParam=new ProParam;

    rsLoadProParam(ConfigFileName,proParam,&cvSize(Temp->width,Temp->height));

    ProMem* proMem=new ProMem;
    rsInitProMem(proParam,proMem);

//    cout<<proParam->OffsetY<<endl;
//    cout<<proParam->HeatConfig.threshold<<endl;
//    cout<<proParam->HeatConfig.EDnum<<endl;

    // 初始化 Res
    cvCopyImage(Temp,proMem->PreImage);
    cvCvtColor(proMem->PreImage, proMem->grayPre, CV_BGR2GRAY);

    int DirectFlag=0;
    proMem->DirectFlag=DirectFlag;

    proMem->Res = rsInitRes(proParam,proMem->PreImage,proMem->Ho2r,DirectFlag);
    proMem->Res = rsStitch(proParam,proMem);

    //绝对坐标系下的直线
    vector<int>SumXCoord;

    vector<HeatSpotParam> SumHeatSpotInfor;
    SumHeatSpotInfor.clear();

    int id=0;

    for(int i=BeginPos;i<EndPos;i+=Interval)
    {
        cout<<"i:"<<i<<endl;
        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,i);
        Temp=cvQueryFrame(Capture);

#if (STITCH==ON)
        int PointsNum= rsUpdateStitching(Temp,proMem,proParam);
#endif

#if (LINE==ON)
        //------直线检测
        vector<int> XCoord;
        XCoord.clear();

        vector<int> YCoord;
        YCoord.clear();

        rsGetXCoord(Temp,XCoord,proMem,proParam);
        rsGetYCoord(Temp,YCoord,proMem,proParam);

        rsDrawVertLines(Temp,XCoord);
        rsDrawHorLines(Temp,YCoord);

        rsDrawRect(Temp,&proParam->VertRect,CV_RGB(128,0,0),1);

//        AddCoordX(SumXCoord,XCoord,proMem);
        UpdateXCoord(SumXCoord,XCoord,proMem);

#endif
        //------热斑检测
#if (SPOT==ON)

        vector<HeatSpotParam> HeatSpotInfor;
        HeatSpotInfor.clear();
        HeatSpotDetect(Temp,cvRect(0,0,proParam->ImageSize.width,proParam->ImageSize.height),HeatSpotInfor,&proParam->HeatConfig,id,i);

        GetGlobalCoord(HeatSpotInfor,proMem->Hn2r);
        GetSpotRow(HeatSpotInfor,YCoord);
        GetSpotCol(HeatSpotInfor,SumXCoord);

        //更新全局信息
//        AddSoptInfor(SumHeatSpotInfor,HeatSpotInfor);
        UpdateHeatSpotInfor(SumHeatSpotInfor,HeatSpotInfor);

        for(int j=0;j<HeatSpotInfor.size();j++)
        {
            cvCircle(Temp,cvPoint(HeatSpotInfor[j].x,HeatSpotInfor[j].y),6,CV_RGB(0,255,0),2);
        }
        rsDrawRect(Temp,&proParam->SpotRect,CV_RGB(255,0,0),1);
#endif

        //------显示
//        rsDrawVertLines(proMem->Res,SumXCoord);
//        rsDrawPoints(proMem->CurrImage,proMem->Ps2,PointsNum,3,1,CV_RGB(0,255,0));
//        cvShowImage("Curr",proMem->CurrImage);
//        cvShowImage("Res",proMem->Res);
        cvShowImage("Temp",Temp);
//        cvShowImage("Res",proMem->Res);

        cvWaitKey(10);
    }

//    GetSpotCol(SumHeatSpotInfor,SumXCoord);

//
    rsDrawVertLines(proMem->Res,SumXCoord);
    MarkResHeatSpot(proMem->Res,SumHeatSpotInfor,proParam);

    for(int i=0;i<SumHeatSpotInfor.size();i++)
    {
        HeatSpotParam hsp=SumHeatSpotInfor[i];
        cout<<"Row: "<<hsp.Row<<" Col: "<<hsp.Col<<"gX: "<<hsp.GlobalX<<" gY:"<<hsp.GlobalY<<endl;

        cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,hsp.Pos);
        Temp=cvQueryFrame(Capture);
        char FileName[20]={0};
        sprintf(FileName,"HeatSpot_%d.jpg",i,Temp);
        cvSaveImage(FileName,Temp);
    }


    cvSaveImage("Res.jpg",proMem->Res);

    cout<<"OK"<<endl;

    //撤销
    rsReleaseProMem(&proMem);
    cvReleaseCapture(&Capture);
    delete proParam;
    return 0;
}



int main()
{
    int BeginPos=6;
    int Interval=1;
    rsVideoDetect("F:/2017_01.mp4",BeginPos,Interval);
    return 0;
}

#elif(Running==Test22)

#include "highgui.h"
#include "cv.h"
#include "cxcore.h"
#include <stdio.h>
#include <iostream>
#include <opencv2\highgui\highgui.hpp>

using namespace std;
using namespace cv;

#define PI 3.1415926


struct HeatSpotParam
{
   int x;
   int y;
   int Radius;
};

//如果需要算法的调节参数就这么写
struct HeatSpotConfig //该结构里的参数可由外部文件获得
{
    int threshold;//热斑检测二值化阈值
    int EDnum; //腐蚀膨胀次数
};

//大津分割
int rsOtsu(IplImage* img)
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
       a = (dmax-dmin)/(smax-smin);
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

int rsHeatSpotDetect(IplImage* Image,CvRect ROI,
            vector<HeatSpotParam>& heatspotParam
            ,HeatSpotConfig* heatspotConfig)
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
    int height = size.height, width = size.width;

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
        double r1 = sqrt(s/PI);
        double length = cvArcLength(contoursTemp);//轮廓周长
        double r2 = length/(2*PI);
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

//获得ROI
CvRect rsGetRoi(IplImage* Image,CvSize size)
{
    CvRect rect = {0};

    rsOtsu(Image);

    IplImage* temp_img = cvCreateImage(size,8,1);//注意释放

    cvDilate(Image,temp_img,NULL,6);//膨胀
    cvErode(temp_img,Image,NULL,6);//腐蚀   腐蚀、膨胀次数决定图像的二值化质量

    cvCanny( Image, temp_img, 50, 200, 3 );

    CvMemStorage* storage = cvCreateMemStorage(0);
    CvSeq* lines = 0;
    lines = cvHoughLines2( temp_img, storage, CV_HOUGH_STANDARD, 1, CV_PI/180, 100, 0, 0 );
    cvReleaseImage(&temp_img);
    //求取ROI区域的坐标
    int Xmin=640,Xmax=0,Ymin=480,Ymax=0;
    for( int i = 0; i < MIN(lines->total,100); i++ )
    {
        int x,y;
        float* line = (float*)cvGetSeqElem(lines,i);
        float rho = line[0];
        float theta = line[1];
        double a = cos(theta), b = sin(theta);
        double x0 = a*rho, y0 = b*rho;
        x = cvRound(x0);
        y = cvRound(y0);
        //确定y
        if(theta > 1.5)
        {
            if(y < Ymin)
            {
                Ymin = y;
            }
            if(y > Ymax)
            {
                Ymax = y;
            }
        }
        else
        {
            Ymin =0;
            Ymax =size.height;
        }
        //确定x
        if(theta < 0.08)
        {
            if(x < Xmin)
            {
                Xmin = x;
            }
            if(x > Xmax)
            {
                Xmax = x;
            }
        }
        else
        {
            Xmin =0;
            Xmax =size.width;
        }

    }
    //确定ROI
    if(Xmin>10)
    {
        rect.x = Xmin-10;
    }
    else
        rect.x = 0;
    if(Ymin>10)
    {
        rect.y = Ymin-10;
    }
    else
        rect.y=0;
    if(size.height-Ymax>10)
    {
        rect.height = (Ymax+10) - rect.y;
    }
    else
        rect.height = size.height - rect.y;
    if(size.width-Xmax>10)
    {
        rect.width = (Xmax+10) - rect.x;
    }
    else
        rect.width = size.width - rect.y;

    return rect;
}

int main()
{
    int x=20;
    int y=30;
    char S[100];
    sprintf(S,"X: %d Y %d",x,y);


    strstream ss;
    string Str;
    ss <<"X: ";
    ss<<x;
    ss<<"Y: ";
    ss<<y;
    ss >> Str;

    cout<<S<<endl;

    return 0;

    IplImage* src_image = cvLoadImage( "F:/2.jpg", 1 );
    if(!src_image)
        return -1;
    cvShowImage("src_before", src_image);

    CvSize size = cvGetSize(src_image);
    int height = size.height, width = size.width;

    IplImage* temp_image = cvCreateImage(size,8,1);

    //灰度变换
    cvCvtColor(src_image,temp_image,CV_BGR2GRAY);

    //获得图像的ROI
    CvRect roirect = rsGetRoi(temp_image,size);

    vector<HeatSpotParam> heatspotParam;
    HeatSpotConfig heatspotConfig;
    heatspotConfig.EDnum = 2; //腐蚀膨胀次数设为2
    heatspotConfig.threshold = 217;//二值化阈值设为217

    //热斑检测
    cout<<roirect.x<<endl;
    cout<<roirect.y<<endl;

    cout<<roirect.width<<endl;
    cout<<roirect.height<<endl;

    int hotnum=rsHeatSpotDetect(src_image,roirect,heatspotParam,&heatspotConfig);
    cout << "hotnum=" <<hotnum<< endl;



    //输出热斑信息
    vector<HeatSpotParam>::iterator it = heatspotParam.begin();
    for(int i=0;i < heatspotParam.size();i++)
    {
        cout<<"热斑"<<i+1<<"信息为："<<endl;
        cout<<"("<<(*it).x<<','<<(*it).y<<','<<(*it).Radius<<")"<<endl;

        cvCircle(src_image,cvPoint((*it).x,(*it).y+roirect.y),3,CV_RGB(255,0,0),2);

        it++;
    }

    cvShowImage("src_after",src_image);
    cvWaitKey(0);
    return 0;
}


#endif

