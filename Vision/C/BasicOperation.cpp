#include "BasicOperation.h"

int rsDrawPoints(IplImage* Image,CvPoint* Points,int Num,int Scope,int Shape,CvScalar Color)
{
    for (int i=0;i<Num;i++)
    {
        if (Shape==SQUARE)
        {
            cvRectangle(Image,cvPoint(Points[i].x-Scope,Points[i].y-Scope),cvPoint(Points[i].x+Scope,Points[i].y+Scope), Color);
        }
        if (Shape==CIRCLE)
        {
            int x=Points[i].x;
            int y=Points[i].y;
            cvCircle(Image,cvPoint(x,y),Scope,Color);
        }
    }
    return 0;
}

int rsDrawPoints(IplImage* Image,CvPoint2D32f * Points,int Num,int Scope,int Shape,CvScalar Color)
{
    for (int i=0;i<Num;i++)
    {
        if (Shape==SQUARE)
        {
            cvRectangle(Image,cvPoint(Points[i].x-Scope,Points[i].y-Scope),cvPoint(Points[i].x+Scope,Points[i].y+Scope), Color);
        }
        if (Shape==CIRCLE)
        {
            int x=Points[i].x;
            int y=Points[i].y;
            cvCircle(Image,cvPoint(x,y),Scope,Color,-1);
        }
    }
    return 0;
}

CvMat* rsGetMaskFromROI(CvSize Size,CvRect ROI)
{
    CvMat* Mask=cvCreateMat(Size.height,Size.width,CV_8UC1);

    cvZero(Mask);
    for(int row=ROI.y;row<ROI.y+ROI.height;row++)
    {
        for(int col=ROI.x;col<ROI.x+ROI.width;col++)
        {
            rsMat8U(Mask,row,col)=1;
        }
    }
    return Mask;
}

IplImage* rsGetComposeImage(IplImage* Image1, IplImage* Image2,int ShowType)
{
        if (!Image1||!Image2)
        {
                return 0;
        }
        IplImage* stacked=0;
        //创建一个以两副图的最大长和最大宽的图像!
        //水平
        if (ShowType==1)
        {
                stacked = cvCreateImage( cvSize( Image1->width+Image2->width,MAX(Image1->height,Image2->height)),Image1->depth,Image1->nChannels);
                cvZero(stacked);//清空图像!
                //把图像1干到stacked的感兴趣!
                cvSetImageROI( stacked, cvRect( 0, 0, Image1->width, Image1->height ) );
                cvAdd( Image1, stacked, stacked, NULL );

                //把图像2干到stacked的感兴趣!和上一个感兴趣不一样!
                cvSetImageROI( stacked, cvRect(Image1->width, 0, Image2->width, Image2->height) );
                cvAdd( Image2, stacked, stacked, NULL );
                cvResetImageROI( stacked );
        }
        //垂直
        if (ShowType==0)
        {
                stacked = cvCreateImage( cvSize( MAX(Image1->width,Image2->width),Image1->height+Image2->height),Image1->depth,Image1->nChannels);
                cvZero(stacked);//清空图像!
                //把图像1干到stacked的感兴趣!
                cvSetImageROI( stacked, cvRect( 0, 0, Image1->width, Image1->height ) );
                cvAdd( Image1, stacked, stacked, NULL );

                //把图像2干到stacked的感兴趣!和上一个感兴趣不一样!
                cvSetImageROI( stacked, cvRect(0, Image1->height, Image2->width, Image2->height) );
                cvAdd( Image2, stacked, stacked, NULL );
                cvResetImageROI( stacked );
        }
        if (ShowType==2)//斜!
        {
                stacked = cvCreateImage( cvSize( Image1->width+Image2->width,Image1->height+Image2->height),Image1->depth,Image1->nChannels);
                cvZero(stacked);//清空图像!
                //把图像1干到stacked的感兴趣!
                cvSetImageROI( stacked, cvRect( 0, 0, Image1->width, Image1->height ) );
                cvAdd( Image1, stacked, stacked, NULL );

                //把图像2干到stacked的感兴趣!和上一个感兴趣不一样!
                cvSetImageROI( stacked, cvRect(Image1->width, Image1->height, Image2->width, Image2->height) );
                cvAdd( Image2, stacked, stacked, NULL );
                cvResetImageROI( stacked );
        }
        return stacked;
}

IplImage* rsMatchImage(IplImage* Image1,IplImage* Image2,CvPoint* Keys1,CvPoint* Keys2,int Num,double Ratio,int ShowType,CvScalar Color)
{
        IplImage* ComposeImage=rsGetComposeImage(Image1,Image2,ShowType);
        if (!ComposeImage)
        {
                return 0;
        }

        for (int i=0;i<Num;i++)
        {
                if (ShowType==1)//
                {
                        Keys2[i].x+=Image1->width;
                }
                if(ShowType==0)//
                {
                        Keys2[i].y+=Image1->height;
                }
                if (ShowType==2)//斜!
                {
                        Keys2[i].x+=Image1->width;
                        Keys2[i].y+=Image1->height;
                }
                cvLine(ComposeImage, Keys1[i],Keys2[i],Color);
        }

        IplImage* NewComposeImage=cvCreateImage(cvSize(ComposeImage->width*Ratio,ComposeImage->height*Ratio),IPL_DEPTH_8U,3);
        cvResize(ComposeImage,NewComposeImage,CV_INTER_AREA);
        cvReleaseImage(&ComposeImage);
        return NewComposeImage;
}

int rsGradient(IplImage* Image,IplImage** Mag,IplImage** Ori,CvRect* ImageROI,void* ExParam)
{
    if (!Image)
    {
        return 1;
    }

    //参数
    double Scale=1.0/255.0; // 转32位时的比例 1/255 将图像像素值从[0-255]映射到[0-1.0]
    int Size=3;             // cvSobel卷积窗大小
    int IsDegree=1;         //Ori 单位为角度

    CvRect* imageROI=0;
    if(ImageROI)
    {
        imageROI=ImageROI;
    }
    else
    {
        imageROI=new CvRect;
        imageROI->x=0;
        imageROI->y=0;
        imageROI->width=Image->width;
        imageROI->height=Image->height;
    }
    //转灰度
    IplImage* Src=Image;
    bool IsCreate=false;
    if(Image->nChannels>1)
    {
        Src=cvCreateImage(cvSize(Image->width,Image->height),Image->depth,1);
cvSetImageROI(Src,imageROI[0]);
        cvCvtColor(Image, Src, CV_BGR2GRAY);
        IsCreate=true;
    }

    //转为32位灰度
    IplImage* Gray32=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_32F,1);
cvSetImageROI(Gray32,imageROI[0]);
    cvConvertScale( Src, Gray32, Scale, 0);

    //创建梯度图像内存
    IplImage* dx=cvCreateImage(cvSize(Src->width,Src->height),IPL_DEPTH_32F,1);
    IplImage* dy=cvCreateImage(cvSize(Src->width,Src->height),IPL_DEPTH_32F,1);
    cvZero(dx);
    cvZero(dy);
cvSetImageROI(dx,imageROI[0]);
cvSetImageROI(dy,imageROI[0]);

    IplImage* ori=cvCreateImage(cvSize(Src->width,Src->height),IPL_DEPTH_32F,1);
    IplImage* mag=cvCreateImage(cvSize(Src->width,Src->height),IPL_DEPTH_32F,1);
    cvZero(ori);
    cvZero(mag);
cvSetImageROI(ori,imageROI[0]);
cvSetImageROI(mag,imageROI[0]);

    //Sobel 计算梯度的dx 与dy
    cvSobel(Gray32,dx,1,0,Size);//dx
    cvSobel(Gray32,dy,0,1,Size);//dy

    //计算梯度的幅值Mag与角度Ori
    cvCartToPolar(dx,dy,mag,ori,IsDegree);


    //使角度范围从-180°-180° 转为0°-360°
    //不需要转了已经是0°-360°
    //  cvAddS(ori,cvScalarAll(180.0),ori);

cvResetImageROI(mag);
cvResetImageROI(ori);

    Mag[0]=mag;
    Ori[0]=ori;

    if(dx)
    {
        cvReleaseImage(&dx);
        dx=0;
    }

    if(dy)
    {
        cvReleaseImage(&dy);
        dy=0;
    }
    if (IsCreate)
    {
        cvReleaseImage(&Src);
    }
    if(Gray32)
    {
        cvReleaseImage(&Gray32);
    }

    if(!ImageROI)//当ImageROI为空时imageROI被开辟内存，因此要释放
    {
        delete imageROI;
    }

    return 0;
}

int rsDrawRect(IplImage* Image,CvRect* Rect,CvScalar Color,int thickness, int line_type, int shift)
{
    cvRectangle(Image,cvPoint(Rect->x,Rect->y), cvPoint( Rect->x+Rect->width-1,Rect->y+Rect->height-1),
                 Color, thickness ,line_type, shift);
    return 0;
}

int rsNormalizeVector(float* Vector,int Num)
{
    if (!Vector)
    {
        return 1;
    }

    float Sum=0;
    for (int i=0;i<Num;i++)
    {
        Sum+=Vector[i];
    }
    if(!Sum)
    {
        return -1;
    }

    for (int i=0;i<Num;i++)
    {
        Vector[i]=Vector[i]/Sum;
    }
    return 0;
}

int rsNormalizeVector(vector<float>& Vector)
{

    float Sum=0;
    int Num=Vector.size();
    for (int i=0;i<Num;i++)
    {
        Sum+=Vector[i];
    }
    if(!Sum)
    {
        return -1;
    }
#if 0
    for (int i=0;i<Num;i++)
    {
        Vector[i]=Vector[i]/Sum;
    }
    cout<<endl;
#endif
    return 0;
}

CvMat* rsComposeMat(CvMat* Mat1,CvMat* Mat2,CvMat** dst,int Type)
{
    if(!(Mat1||Mat2))
    {
        return dst[0];
    }

    //有一个为null
    if(!(Mat1 && Mat2))
    {
        CvMat* Temp=0;
        Temp=cvCloneMat(Mat1?Mat1:Mat2);
        if(dst[0])
        {
            cvReleaseMat(dst);
        }
        dst[0]=Temp;
        return dst[0];
    }

    IplImage* Image1=cvCreateImageHeader(cvGetSize(Mat1),IPL_DEPTH_32F,1);
    IplImage* Image2=cvCreateImageHeader(cvGetSize(Mat2),IPL_DEPTH_32F,1);

    Image1=cvGetImage(Mat1,Image1);
    Image2=cvGetImage(Mat2,Image2);

    IplImage* ComposeImage= rsGetComposeImage(Image1,Image2,Type);
    CvMat* ComposeMat=cvCreateMat(ComposeImage->height,ComposeImage->width,CV_32FC1);

    cvConvert( ComposeImage, ComposeMat );

//    cvReleaseImage(&Image1);
//    cvReleaseImage(&Image2);
    cvReleaseImage(&ComposeImage);

    if(dst[0])
    {
        cvReleaseMat(dst);
        dst[0]=ComposeMat;
    }
    return ComposeMat;
}

int rsUpdateBackground (IplImage* Background, IplImage* Current,double* Num,CvRect* ROI)
{
    //存在测试
    if((!Background) || (!Current))
    {
        return -1;
    }
    //数据位与通道数测试
    if((Background->depth != Current->depth) || (Background->nChannels !=Current->nChannels))
    {
        return -1;
    }

    if(ROI)
    {
        cvSetImageROI(Background,ROI[0]);
        cvSetImageROI(Current,ROI[0]);
    }

    double Sum=Num[0]+1.0;
    double alpha=Num[0]/Sum;
    double beta=1.0/Sum;

    cvAddWeighted(Background,alpha,Current,beta,0,Background);

    Num[0]=Sum;
    return Num[0];
}

int rsBackgroundDetect(IplImage* Background, IplImage* Current, IplImage *Dst,
                       double Threshold, CvRect* DetectROI,int DetectNum,void* ExtParam)
{
    //存在测试
    if((!Background) || (!Current) ||!(Dst))
    {
        return -1;
    }

    //数据位与通道数测试
    if((Background->depth != Current->depth) ||  (Background->depth != Dst->depth)
        || (Background->nChannels !=Current->nChannels) || (Background->nChannels !=Dst->nChannels))
    {
        return -1;
    }

    cvResetImageROI(Background);
    cvResetImageROI(Current);
    cvResetImageROI(Dst);

    int* Res=new int[DetectNum];

    int R=1;

    double* BinThres=0;
    if(ExtParam)
    {
        //二值化
        BinThres=(double*) ExtParam;
    }

    if(!DetectROI)
    {
        return -1;
    }

    rsfor(i,DetectNum)
    {
        cvSetImageROI(Background,DetectROI[i]);
        cvSetImageROI(Current,DetectROI[i]);
        cvSetImageROI(Dst,DetectROI[i]);

        cvAbsDiff(Background,Current,Dst);

        if(ExtParam)
        {
            cvThreshold(Dst,Dst,BinThres[0],1.0,CV_THRESH_BINARY);
        }
        CvScalar res = cvSum( Dst );
        double Sum=0;
        rsfor(j,4)
        {
            Sum+=res.val[j];
        }
        Res[i]=Sum>Threshold?1:0;
        R=R&&Res[i];
//cout<<"Res["<<i<<"]"<<Res[i]<<endl;
    }

    cvResetImageROI(Background);
    cvResetImageROI(Current);
    cvResetImageROI(Dst);

    delete[] Res;

    return R;
}

int rsInitCornerParam(CvSize Size,CvRect ROI,IplImage** Temp1,IplImage** Temp2,CvMat** Mask)
{
    if(Temp1[0])
    {
       cvReleaseImage(&Temp1[0]);
       Temp1[0]=0;
    }

    if(Temp2[0])
    {
       cvReleaseImage(&Temp2[0]);
       Temp2[0]=0;
    }

    if(Mask[0])
    {
        cvReleaseMat(&Mask[0]);
        Mask[0]=0;
    }

    Temp1[0]=cvCreateImage(Size, IPL_DEPTH_32F, 1);
    Temp2[0]=cvCreateImage(Size, IPL_DEPTH_32F, 1);

    Mask[0]=rsGetMaskFromROI(Size,ROI);

    return 0;
}

int rsHarris(IplImage* img,CvArr* Mask,CvPoint2D32f* Points,
             IplImage* Temp1,IplImage* Temp2,
             int UseHarris,double QualityLevel,double MinDis,int BlockSize,double K)
{
    int CornerCount=0;
    cvGoodFeaturesToTrack(img,Temp1,Temp2,
                          Points,&CornerCount,QualityLevel,
                          MinDis,Mask,BlockSize,UseHarris,K);
    return CornerCount;
}

int rsGetCorners(IplImage* Image,CvPoint2D32f** Corners,int MaxNum,
                 int useHarris,CvRect* ROI,double QualityLevel,
                 double MinDis,CvMat* Mask,int EigBlockSize, double K)
{


    if(!Image)
    {
        return RS_ERROR;
    }

    //创建角点内存
    if(Corners[0])
    {
        delete[] Corners[0];
        Corners[0]=0;
    }

    Corners[0]=new CvPoint2D32f[MaxNum];

    //转灰度
    IplImage* grayImage= 0;

    //将原图灰度化
    if (Image->nChannels>1)
    {
        grayImage = cvCreateImage(cvSize(Image->width,Image->height), IPL_DEPTH_8U,1);
        cvCvtColor(Image, grayImage, CV_BGR2GRAY);
    }
    else
    {
        grayImage=Image;
    }

    if(ROI)
    {
        cvSetImageROI(grayImage,ROI[0]);
    }

    //创建连个与原图大小相同的临时图像
    IplImage* Temp1= cvCreateImage(cvSize(Image->width,Image->height), IPL_DEPTH_32F, 1);
    IplImage* Temp2= cvCreateImage(cvSize(Image->width,Image->height), IPL_DEPTH_32F, 1);


    //提取角点
    int CornerCount=0;
    cvGoodFeaturesToTrack(grayImage,Temp1,Temp2,
                          Corners[0],&CornerCount,QualityLevel,
                          MinDis,Mask,EigBlockSize,useHarris,K);


    if(ROI)
    {
        cvResetImageROI(grayImage);
    }

    if(Image->nChannels>0)
    {
        cvReleaseImage(&grayImage);
        grayImage=0;
    }

    cvReleaseImage(&Temp1);
    Temp1=0;
    cvReleaseImage(&Temp2);
    Temp2=0;

    return CornerCount;
}
