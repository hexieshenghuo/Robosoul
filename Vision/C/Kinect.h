/*========================================================================
�ļ����ƣ�MLKinect.h
����������OpenNI1.0+Nite1.3+MS SensorKinect-Win32-5.0.0��Kinect����!
����: ����
���ܣ�
    1)Kinect���ͼ���RGBͼ�����ݵĶ�ȡ!
˵����
    1)���ͼ��Ϊ16U��1����!��Ҫר�ŵķ���ָ��!//һ���ͼ��8��[0-255]��ɫ��[0-255][0-255][0-255] 2^8=256 16U:0-65535
    2)SamplesConfig.xml����Ҫ��ȡ�ļ�!������SAMPLE_XML_PATH��!������Ҫ�ı�!
�޸ļ�¼:



========================================================================*/
#include <math.h>

#include <XnCppWrapper.h>
#include <XnOS.h>
using namespace xn;

#include "VisionConfig.h"
#include <cv.h>
#include <cxcore.h>

#pragma once

#ifndef SUCCESS
#define SUCCESS 0
#endif

#ifndef FAIL
#define FAIL 1
#endif

#ifndef ML_OK
#define ML_OK 1
#endif

#ifndef ML_NO
#define ML_NO 0
#endif

#ifndef rsGetPixelValue(Image,x,y,i)
   #define rsGetPixelValue(Image,x,y,i) ( ((uchar*)(Image->imageData + Image->widthStep*(y)))[(x)*3+i] )
#endif

//����16U���ͼ��!
#define GetDepthImage(Image,x,y) (((XnUInt16*)(Image->imageData + Image->widthStep*(y)))[x])

//XML�ļ�·��!
//������Ҫ����!
#define SAMPLE_XML_PATH ("D:/Kinect/OpenNI/Data/SamplesConfig.xml")
//#define SAMPLE_XML_PATH "C:\\SamplesConfig.xml" //������Ҫ����!


//ͼ���С!
#define WIDTH  640
#define HEIGHT 480


class Kinect
{
    //����!
public:
    Kinect();
//    virtual ~Kinect();
    int Init();
    //����!
public:
    XnStatus rc;
    Context g_context;     //Kinect��������!
    DepthGenerator g_depth;//���ͼ��������!
    ImageGenerator g_image;//RGBͼ��������!

    DepthMetaData g_depthMD;//���ͼ������!
    ImageMetaData g_imageMD;//RFBͼ������!
    //����!
public:

    //�ж�ͼ���Ƿ�Ϸ�!
    int IsLegal(IplImage* Image,int Channel=3,int Width=WIDTH,int Height=HEIGHT);

    //��ȡͼ������!
    int GetImageData( IplImage* DepthImage,IplImage* RGBImage);

    //�õ�һ��Kinect��RGBͼ��!���ڳ�ʼ��!
    IplImage* CreateKinectRGBImage();

    //�õ�һ��Kinect��Depthͼ��!���ڳ�ʼ��!
    IplImage* CreateKinectDepthImage();

    //------�㷨------//
    //ȷ���ֲ�λ��!//������ɫ��!
//  int GetHandPosition(RS_OUT IplImage* DepthImage,RS_OUT IplImage* BGRImage,RS_OUT double Pos[]);

    //��ʼ��һ��ͼ��Ƭ!
    //��Slices�޸ģ�BGRImage->Origianl->BGR,DepthImage->Depth,PointMat����ʼ��!
//  int InitKinectSlice(RS_IN IplImage* BGRImage,RS_IN IplImage* DepthImage, SRGBDImage* Slice);

    //�ָ�ͼ��!�������ͼ�����طֲ�����������ǰ�˵Ĳ���!
    //��Slices�޸ģ���������->PointMat!
    //Threshold:����ǰ����ռ����!BinNum:ֱ��ͼϵ����!
//  int Foreground_Ratio(RGBDImage* Slice,RS_IN double Threshold=0.36,int BinNum=256*16);

    //�ָ�ͼ��!�������ͼ�����ر���ǰ��ָ�������ͼ�񲿷�!
    //��Slices�޸ģ���������->PointMat!
    //DepthRange:������ȷ�Χ
    //    int	Foreground_Depth(RS_IN RS_OUT RGBDImage* Slice, RS_IN XnInt16 DepthRange);

    //    int	Foreground_Depth_D_E(RS_IN RS_OUT RGBDImage* Slice,RS_IN XnInt16 DepthRange,
    //                                     int Order=0, int DIterNum=1,int EIterNum=1,
    //                                     int Use_Kernel=NULL,int KSize=3);

};
