/*========================================================================
文件名称：MLKinect.h
描述：基于OpenNI1.0+Nite1.3+MS SensorKinect-Win32-5.0.0的Kinect操作!
作者: 马乐
功能：
    1)Kinect深度图像和RGB图像数据的读取!
说明：
    1)深度图像为16U型1数据!需要专门的访问指令!//一般的图像8：[0-255]颜色：[0-255][0-255][0-255] 2^8=256 16U:0-65535
    2)SamplesConfig.xml是需要读取文件!定义在SAMPLE_XML_PATH里!根据需要改变!
修改记录:



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

//访问16U深度图像!
#define GetDepthImage(Image,x,y) (((XnUInt16*)(Image->imageData + Image->widthStep*(y)))[x])

//XML文件路径!
//根据需要设置!
#define SAMPLE_XML_PATH ("D:/Kinect/OpenNI/Data/SamplesConfig.xml")
//#define SAMPLE_XML_PATH "C:\\SamplesConfig.xml" //根据需要设置!


//图像大小!
#define WIDTH  640
#define HEIGHT 480


class Kinect
{
    //构造!
public:
    Kinect();
//    virtual ~Kinect();
    int Init();
    //属性!
public:
    XnStatus rc;
    Context g_context;     //Kinect环境配置!
    DepthGenerator g_depth;//深度图像生成器!
    ImageGenerator g_image;//RGB图像生成器!

    DepthMetaData g_depthMD;//深度图像数据!
    ImageMetaData g_imageMD;//RFB图像数据!
    //操作!
public:

    //判断图像是否合法!
    int IsLegal(IplImage* Image,int Channel=3,int Width=WIDTH,int Height=HEIGHT);

    //读取图像数据!
    int GetImageData( IplImage* DepthImage,IplImage* RGBImage);

    //得到一个Kinect的RGB图像!用于初始化!
    IplImage* CreateKinectRGBImage();

    //得到一个Kinect的Depth图像!用于初始化!
    IplImage* CreateKinectDepthImage();

    //------算法------//
    //确定手部位置!//基于颜色的!
//  int GetHandPosition(RS_OUT IplImage* DepthImage,RS_OUT IplImage* BGRImage,RS_OUT double Pos[]);

    //初始化一个图像片!
    //对Slices修改：BGRImage->Origianl->BGR,DepthImage->Depth,PointMat被初始化!
//  int InitKinectSlice(RS_IN IplImage* BGRImage,RS_IN IplImage* DepthImage, SRGBDImage* Slice);

    //分割图像!根据深度图像像素分布按比例保留前端的部分!
    //对Slices修改：保留部分->PointMat!
    //Threshold:保留前景所占比例!BinNum:直方图系分数!
//  int Foreground_Ratio(RGBDImage* Slice,RS_IN double Threshold=0.36,int BinNum=256*16);

    //分割图像!根据深度图像像素保留前端指定距离的图像部分!
    //对Slices修改：保留部分->PointMat!
    //DepthRange:保留深度范围
    //    int	Foreground_Depth(RS_IN RS_OUT RGBDImage* Slice, RS_IN XnInt16 DepthRange);

    //    int	Foreground_Depth_D_E(RS_IN RS_OUT RGBDImage* Slice,RS_IN XnInt16 DepthRange,
    //                                     int Order=0, int DIterNum=1,int EIterNum=1,
    //                                     int Use_Kernel=NULL,int KSize=3);

};
