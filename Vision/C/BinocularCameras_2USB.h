/*---------------------------------------------------------------------------------
文件名称：BinocularCameras_2USB.h
版本：1.0
功能：RS.Vision
目的：用于基于OpenCV双目摄像设备的操作
作者：MaLe
说明：


修改记录:

File Name: BinocularCameras.h
Version: 1.0
Function: RS.Vision
Objective:
Descriprtion:
Revise Record:

---------------------------------------------------------------------------------*/

#ifndef BINOCULARCAMERAS_H
#define BINOCULARCAMERAS_H

#include <cv.h>
#include <cxcore.h>
#include <highgui.h>
#include "VisionConfig.h"

//---------表示标识宏

//是否用DirectShow
#define RS_USE_SDSHOW   RS_YES

//读取方式偏移
#if (RS_USE_SDSHOW==RS_YES)
   #define RS_ID_OFFSET   (CV_CAP_DSHOW)
#else
   #define RS_ID_OFFSET   (CV_CAP_ANY)
#endif

//双目ID
#if (RS_USE_SDSHOW==RS_YES)
   #define RS_DEVICE_ID_L  (0)
   #define RS_DEVICE_ID_R  (1)
#else
   #define RS_DEVICE_ID_L  (1)
   #define RS_DEVICE_ID_R  (0)
#endif

//读取设备ID
#define RS_CAMERA_ID_L    ( RS_DEVICE_ID_L + RS_ID_OFFSET)
#define RS_CAMERA_ID_R    ( RS_DEVICE_ID_R + RS_ID_OFFSET)

//打开视频结果状态
#define RS_OPEN_L       (1) // 只有左摄像机打开
#define RS_OPEN_R       (2) // 只有右摄像机打开
#define RS_OPEN_ALL     (3) // 全部打开
#define RS_OPEN_NULL    (0) // 全没打开

class BinocularCameras
{
//方法
public:
    BinocularCameras();
//  CameraImageInfor GetCameraImageInfor(IplImage* Image);
    int Open(int CamaeraID_L=RS_CAMERA_ID_L,
             int CameraID_R=RS_CAMERA_ID_R);
    int CreateOutImage(IplImage* pFrame,int LorR);
    int GetImages();
    int GetFirstFrame();
    int Close();
//变量
public:
    int CameraID_L;      //左侧相机设备ID
    int CameraID_R;      //右侧相机设备ID
    IplImage* OutImageL; //左侧相机输出图像
    IplImage* OutImageR; //右侧相机输出图像
//private:
  //
  IplImage* FrameL;
  IplImage* FrameR;

 //获取摄像头
  CvCapture* CaptureL;
  CvCapture* CaptureR;

};

#endif // BINOCULARCAMERAS_H
