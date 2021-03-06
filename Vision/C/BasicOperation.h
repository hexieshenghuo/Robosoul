/*---------------------------------------------------------------------------------
文件名称：BasicOperation.h
版本：1.0
功能：RS.Vision
目的：用于基于OpenCV图像处理的基本操作
作者：male
说明：


修改记录:

File Name: BasicOperation.h
Version: 1.0
Function: RS.Vision
Objective: Basic operation for image process based on OpenCV
Descriprtion:
Revise Record:

---------------------------------------------------------------------------------*/

#ifndef RS_BASCIOPERATION_H
#define RS_BASCIOPERATION_H
#endif

#include"VisionConfig.h"

#ifdef RS_OPENCV_1
 #include<opencv/cxcore.h>
 #include<opencv/cv.h>
 #include<opencv/highgui.h>
#else

#endif

#include<vector>
using namespace std;
#pragma once

// for循环
#define rsfor(i,num) for(int i=0;i<(num);(i++))

//
#define RS_OK     (0)
#define RS_ERROR  (-1)

//---角度变换
//---Angle Transform
#ifndef RS_PI
#define RS_PI (3.1415926535897932384626433832795)
#endif

#define rsAngleToPi(Angle)         ((double)Angle/180.0*RS_PI)
#define rsPiToAngle(Angle)         ((double)Angle/RS_PI*180.0)
#define rsPositiveAngle(Angle)     (Angle<0?360+Angle:Angle)

//---图像访问
//---Image Accessing
#define rsImage8U3(Image,x,y,i)    ( ((unsigned char*)(Image->imageData + Image->widthStep*(y)))[(x)*3+i] )
#define rsImage8U1(Image,x,y)      ( ((unsigned char*)(Image->imageData + Image->widthStep*(y)))[(x)] )
#define rsImage32F1(Image,x,y)     ( ( (float*)(Image->imageData + Image->widthStep*(y)) )[x]  )
#define rsImage64D1(Image,x,y)     ( ( (double*)(Image->imageData + Image->widthStep*(y)))[x]   )

//---LUT
#define rsImageLUT8U1(img,x,y,i,LUT) ( ((unsigned char*)(img->imageData + LUT[y]))[(x)*3+i] )
#define rsImageLUT8U3(img,x,y,LUT) ( ((unsigned char*)(img->imageData + LUT[y]))[x] )
#define rsImageLUT32F1(img,x,y,LUT) ( ((float*)(img->imageData + LUT[y]))[x] )
#define rsImageLUT64D1(img,x,y,LUT) ( ((double*)(img->imageData + LUT[y]))[x] )

//---矩阵访问
//---Matrix Accessing
#define rsMat8U(Mat,row,col)  (((unsigned char*)(Mat->data.ptr + Mat->step*(row)))[col])
#define rsMat32F(Mat,row,col) (((float*)(Mat->data.ptr + Mat->step*(row)))[col])
#define rsMat64D(Mat,row,col) ( ((double*)(Mat->data.ptr + Mat->step*(row))[col] )

//---矩阵乘法
// c=ab
#define rsMultiMat(a,b,c)  cvMatMul((a),(b),(c))

// 时间计算
// Computing Time
#define rsStartTime(T)    double T = (double)cvGetTickCount()
#define rsRestartTime(T)  T= (double)cvGetTickCount()
#define rsGetTime(T)      (( (double)cvGetTickCount() - T )/((double)cvGetTickFrequency()*1000.0) )


//画特征点
#define SQUARE 0
#define CIRCLE 1
int rsDrawPoints(IplImage* Image, CvPoint* Points,int Num,int Scope,int Shape,CvScalar Color);
int rsDrawPoints(IplImage* Image, CvPoint2D32f* Points,int Num,int Scope,int Shape,CvScalar Color);

// 返回实际角点数
int rsGetCorners(IplImage* Image,
                 CvPoint2D32f** Corners,
                 int MaxNum,   //特征点最大点
                 int useHarris,   //是否用Harris检测
                 CvRect* ROI, //
                 double QualityLevel=0.1, //以quality_level的值不应当超过1，通常取值为（0.10或是0.01）
                 double MinDis=9, //两点最小距离
                 CvMat *Mask=0, //
                 int EigBlockSize=3,
                 double K=0.04);
// 计算角点
int rsHarris(IplImage* img, CvArr* Mask,CvPoint2D32f* Points,
             IplImage* Temp1=0,IplImage* Temp2=0,
             int UseHarris=1,double QualityLevel=0.01,double MinDis=6,
             int BlockSize=3,double K=0.036);

// 初始化角点提取需要的参数
// 根据Size和 ROI
int rsInitCornerParam(CvSize Size,CvRect ROI,IplImage** Temp1,IplImage** Temp2,CvMat** Mask);

// 根据Size和ROI创建角点提取用的Mask
CvMat* rsGetMaskFromROI(CvSize Size,CvRect ROI);

// 合并2图!
IplImage* rsGetComposeImage(IplImage* Image1, IplImage* Image2,int ShowType=1);

// 生成匹配图!
IplImage* rsMatchImage(IplImage* Image1,IplImage* Image2,
                       CvPoint* Keys1,CvPoint* Keys2,
                       int Num,double Ratio=1.0,
                       int ShowType=1,
                       CvScalar Color=CV_RGB(0,255,0));


//------------梯度 Gradient
int rsGradient(IplImage* Image,IplImage** Mag, IplImage** Ori,
               CvRect *ImageROI=0,//2016.08.04 梯度处理的ROI区域
               void* ExParam=0);


//------------画基本图形
int rsDrawRect(IplImage* Image,CvRect* Rect,CvScalar Color,int thickness=1, int line_type=8, int shift=0);


//------------数据处理
// V[i]=V[i]/Sum;
int rsNormalizeVector(float *Vector, int Num);
int rsNormalizeVector(vector<float>& Vector);


//CvMat 矩阵合并
//目前只适用于数据类型为32FC1
#define VERTICAL  (0)
#define LEVEL     (1)
CvMat* rsComposeMat(CvMat* Mat1, CvMat* Mat2,CvMat** dst=0,int Type = VERTICAL);


//------------背景生成与检测
//根据当前图像Current更新背景图像Background
int rsUpdateBackground (IplImage* Background, IplImage* Current, double *Num, CvRect *ROI=0);

//检测当前图像Current是否为前景
// 1:有目标 0:无目标
int rsBackgroundDetect(IplImage* Background, IplImage* Current, IplImage* Dst,
                       double Threshold, CvRect* DetectROI, int Detectum, void *ExtParam=0);
