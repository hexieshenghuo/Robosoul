#include "Kinect.h"

Kinect::Kinect()
{
    Init();
}

int Kinect::Init()
{
    //���Ȩ��!
    rc = g_context.InitFromXmlFile(SAMPLE_XML_PATH,NULL/*&errors*/);//"C:\\SamplesConfig.XML"
    if (rc == XN_STATUS_NO_NODE_PRESENT)
    {
        ;//��Ӵ�����Ϣ!
        return FAIL;
    }
    else if (rc != XN_STATUS_OK)
    {
        ;//����Ӵ�����Ϣ!
        return FAIL;
    }

    //��������ͼ��!
    rc = g_context.FindExistingNode(XN_NODE_TYPE_DEPTH, g_depth);//Note:��һ������Ϊ�豸����!
    rc = g_context.FindExistingNode(XN_NODE_TYPE_IMAGE, g_image);

    //�����RGBͼ���Ӧ�����!
    //
    g_depth.GetAlternativeViewPointCap().SetViewPoint(g_image);//RGB(X,Y)<->Depth(X,Y)

    return 0;
}

int Kinect::IsLegal(IplImage* Image,int Channel,int Width,int Height)
{
    //ͼ��ָ��!
    if (!Image)
    {
        return ML_NO;
    }

    //ͼ������!
    if (!Image->imageData)
    {
        return ML_NO;
    }

    //ͼ���С!
    if ( (Image->width!=Width )|| (Image->height!=Height))
    {
        return ML_NO;
    }

    //ͼ��ͨ����!
    if (Image->nChannels!=Channel)
    {
        return ML_NO;
    }

    return ML_OK;
}

int Kinect::GetImageData( OUT IplImage* DepthOut,OUT IplImage* BGROut)
{
    //����ͼ���Ƿ�Ϸ�!
    if (!DepthOut)
    {
        return FAIL;
    }
    if (!BGROut)
    {
        return FAIL;
    }

    if (!DepthOut->imageData)
    {
        return FAIL;
    }

    if (!BGROut->imageData)
    {
        return FAIL;
    }

    if ( (BGROut->width!=WIDTH )|| (BGROut->height!=HEIGHT))
    {
        return FAIL;
    }

    if ((DepthOut->width!=WIDTH )|| (DepthOut->height!=HEIGHT))
    {
        return FAIL;
    }

    //��ȡ����!
    if (g_context.WaitAnyUpdateAll() !=XN_STATUS_OK)
    {
        return FAIL;
    }

    g_depth.GetMetaData(g_depthMD);
    g_image.GetMetaData(g_imageMD);

    //���ͼ��!
    memcpy(BGROut->imageData,g_imageMD.Data(),3*WIDTH*HEIGHT*sizeof(XnUInt8));
    memcpy(DepthOut->imageData,g_depthMD.Data(),WIDTH*HEIGHT*sizeof(XnDepthPixel));

    //RGB->BGR!
    cvCvtColor(BGROut,BGROut,CV_RGB2BGR);

    //�������!
    cvFlip(BGROut,BGROut,1);
    cvFlip(DepthOut,DepthOut,1);

    return RS_SUCCESS;
}


//int Kinect::GetHandPosition(IN IplImage* DepthImage,IN IplImage* BGRImage,OUT double Pos[])
//{
//    //�жϺϷ���!
//    if (IsLegal(DepthImage,1)==ML_NO||IsLegal(BGRImage)==ML_NO)
//    {
//        return FAIL;
//    }

//    //����HSVͼ��!
//    IplImage* LabImage=cvCloneImage(BGRImage);

//    //BGR->HSV!
//    cvCvtColor(BGRImage,LabImage,CV_BGR2Lab);

//    double SumX=0;
//    double SumY=0;
//    double SumDepth=0;
//    double SumNum=0;

//    double Threshold=150.0;

//    //ͳ��!
//    for (int x=0;x<WIDTH;x++)
//    {
//        for (int y=0;y<HEIGHT;y++)
//        {
//            uchar L=rsGetPixelValue(LabImage,x,y,0);
//            uchar A=rsGetPixelValue(LabImage,x,y,1);
//            uchar B=rsGetPixelValue(LabImage,x,y,2);
//            //�б�����!
//            if( L>100
//                && A<145 && A>115
//                && B>145 && B<175//Note:�ȽϺ�L<125 && L>115&& A<139
//                &&A>132 && B>145 && B<155
//                && GetDepthImage(DepthImage,x,y)<1200
//                && GetDepthImage(DepthImage,x,y)>0
//                )
//            {
//                SumX+=x;
//                SumY+=y;
//                SumDepth+=GetDepthImage(DepthImage,x,y);
//                SumNum+=1;
//            }
//            else
//            {
//                rsGetPixelValue(BGRImage,x,y,0)=255;
//                rsGetPixelValue(BGRImage,x,y,1)=255;
//                rsGetPixelValue(BGRImage,x,y,2)=255;
//            }
//        }
//    }

//    //����!
//    if (SumNum>0)
//    {
//        Pos[0]=SumX/SumNum;//X!
//        Pos[1]=SumY/SumNum;//Y!
//        Pos[2]=SumDepth/SumNum;//Depth!

//        //�˲�!
//        SumX=0;
//        SumY=0;
//        SumDepth=0;
//        SumNum=0;
//        for (int x=0;x<LabImage->width;x++)
//        {
//            for (int y=0;y<LabImage->height;y++)
//            {
//                uchar L=rsGetPixelValue(LabImage,x,y,0);
//                uchar A=rsGetPixelValue(LabImage,x,y,1);
//                uchar B=rsGetPixelValue(LabImage,x,y,2);
//                //�б�����!
//                if( L>100
//                    && A<145 && A>115
//                    && B>145 && B<175//Note:�ȽϺ�L<125 && L>115
//                    && A<139 && A>132 && B>145 && B<155
//                    && GetDepthImage(DepthImage,x,y)<1200
//                    && GetDepthImage(DepthImage,x,y)>0
//                    )
//                {
//                    if((Pos[0]-x)*(Pos[0]-x)+(Pos[1]-y)*(Pos[1]-y)<Threshold*Threshold)
//                    {
//                        SumX+=x;
//                        SumY+=y;
//                        SumDepth+=GetDepthImage(DepthImage,x,y);
//                        SumNum+=1;
//                    }
//                }
//            }
//        }
//        //�ؼ���!
//        if (SumNum>0)
//        {
//            Pos[0]=SumX/SumNum;//X!
//            Pos[1]=SumY/SumNum;//Y!
//            Pos[2]=SumDepth/SumNum;//Depth!
//        }
//    }

//    //����!
//    cvReleaseImage(&LabImage);

//    return SUCCESS;
//}

IplImage* Kinect::CreateKinectRGBImage()
{
    return cvCreateImage(cvSize(WIDTH,HEIGHT),IPL_DEPTH_8U,3);
}

IplImage* Kinect::CreateKinectDepthImage()
{
    return cvCreateImage(cvSize(WIDTH,HEIGHT),IPL_DEPTH_16U,1);
}

//int Kinect::InitKinectSlice(IN IplImage* BGRImage,IN IplImage* DepthImage, RGBDImage* Slice)
//{
//    //�жϺϷ���!
//    if (IsLegal(DepthImage,1)==ML_NO||IsLegal(BGRImage)==ML_NO)
//    {
//        return FAIL;
//    }
//    if (!Slice)
//    {
//        return FAIL;
//    }

//    //------����!
//    //ԭʼͼ��!
//    Slice->CreateOriginal(BGRImage);

//    //BGRͼ��!
//    if (Slice->BGR)
//    {
//        cvReleaseImage(&Slice->BGR);
//        Slice->BGR=0;
//    }
//    Slice->BGR=cvCloneImage(BGRImage);

//    //Depthͼ��!
//    if (Slice->Depth)
//    {
//        cvReleaseImage(&Slice->Depth);
//        Slice->Depth=0;
//    }
//    Slice->Depth=cvCloneImage(DepthImage);

//    //����ͼ��!
//    if (Slice->PointMat)
//    {
//        cvReleaseImage(&Slice->PointMat);
//        Slice->PointMat=0;
//    }
//    Slice->PointMat=cvCreateImage(cvGetSize(BGRImage),BGRImage->depth,1);
//    memset(Slice->PointMat->imageData,0,sizeof(uchar)*(Slice->PointMat->width)*(Slice->PointMat->height));

//    return 0;
//}


//
//int Kinect::Foreground_Ratio( RGBDImage* Slice,IN double Threshold,int BinNum)
//{
//    //�жϺϷ�!
//    if (!Slice)
//    {
//        return FAIL;
//    }

//    //����������!
//    double* Hist=new double [BinNum];
//    memset(Hist,0,BinNum*sizeof(double));

//    int Rang=65536/BinNum;
//    for(int x=0;x<Slice->Depth->width;x++)
//    {
//        for(int y=0;y<Slice->Depth->height;y++)
//        {
//            XnUInt16 P=GetDepthImage(Slice->Depth,x,y);
//            if (P)
//            {
//                Hist[(int)(P/Rang)]++;
//            }
//        }
//    }

//    double Sum=0;
//    FOR(i,BinNum,
//        Sum+=Hist[i];
//    )
//    double RemainSum=Sum*Threshold;
//    Sum=0;
//    XnInt16 ThresholdDepth=0;
//    for(i=0;i<BinNum;i++)
//    {
//        Sum+=Hist[i];
//        if (Sum>=RemainSum)
//        {
//            ThresholdDepth=i*Rang;
//            break;
//        }
//    }

//    //��ע!
//    for(x=0;x<Slice->Depth->width;x++)
//    {
//        for(int y=0;y<Slice->Depth->height;y++)
//        {
//            XnUInt16 P=GetDepthImage(Slice->Depth,x,y);
//            if (P>0&&P<ThresholdDepth)
//            {
//                MLGetGrayPixel(Slice->PointMat,x,y)=MLGetGrayPixel(Slice->PointMat,x,y)+1;
//            }
//        }
//    }

//    return 0;
//}

//int Kinect::Foreground_Depth(IN OUT MLImageSlices* Slice,IN XnInt16 DepthRange)
//{
//    //�жϺϷ�!
//    if (!Slice)
//    {
//        return FAIL;
//    }

//    XnInt16 MinDepth=0xFFE;//��ǰ������!
//    for(int x=0;x<Slice->Depth->width;x++)
//    {
//        for(int y=0;y<Slice->Depth->height;y++)
//        {
//          XnInt16 Depth=GetDepthImage(Slice->Depth,x,y);
//          if (Depth>0)
//          {
//            MinDepth=min(MinDepth,Depth);
//          }
//        }
//    }

//    for(x=0;x<Slice->Depth->width;x++)
//    {
//        for(int y=0;y<Slice->Depth->height;y++)
//        {
//            XnInt16 Depth=GetDepthImage(Slice->Depth,x,y);
//            if ((Depth>0)&&Depth<=MinDepth+DepthRange)
//            {
//                MLGetGrayPixel(Slice->PointMat,x,y)+=1;
//            }
//        }
//    }
//    //�����ͺ͸�ʴ�˳��ն�!

//    return MinDepth;
//}

//int Kinect::Foreground_Depth_D_E( RGBDImage* Slice,IN XnInt16 DepthRange,
//                                    intOrder,int DIterNum,int EIterNum,
//                                    int Use_Kernel,int KSize)
//{
//    XnInt16 MinDepth=0xFFE;//��ǰ������!
//    MinDepth=Foreground_Depth(Slice,DepthRange);

//    //���͸�ʴ����!
//    cvConvertScale(Slice->PointMat,Slice->PointMat,100);
//    MLFilter_Dilate_Erode(Slice->PointMat,Order,DIterNum,EIterNum,Use_Kernel,KSize);
//    cvThreshold(Slice->PointMat,Slice->PointMat,0,1,CV_THRESH_BINARY);

//    return MinDepth;
//}
