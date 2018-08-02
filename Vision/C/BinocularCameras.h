/*---------------------------------------------------------------------------------
文件名称：BinocularCameras.h
版本：1.0
功能：RS.Vision
目的：用于基于DirectShow双目摄像设备的操作
作者：MaLe
说明：
   1)基于DriectShow，因此只能用于VS编译器
修改记录:

File Name: BinocularCameras.h
Version:  1.0
Function: RS.Vision
Objective:
Descriprtion:
Revise Record:

---------------------------------------------------------------------------------*/

#ifndef BINOCULARCAMERAS_H
#define BINOCULARCAMERAS_H

#include <CameraDS.h>
#include "VisionConfig.h"
#include <cv.h>

//---------预定义宏
//------摄像机ID
#define RS_CAMERA_ID_L (1)
#define RS_CAMERA_ID_R (0)

//------双目图像大小
#define RS_BI_WIDTH  (320)//640//(1280)//(352)//(640)//
#define RS_BI_HEIGHT (240)//360//(720)//(288)//(480)//

//------测试宏
#define RS_USE_POINTER RS_YES

class BinocularCameras
{
//方法
public:
    BinocularCameras();
    int Open(int Camera_ID_L=RS_CAMERA_ID_L, int Camera_ID_R=RS_CAMERA_ID_R);
    int Close();
    int CreateOutImage();
    int UpdateOutImage();
//变量
//private:
    CCameraDS* CameraL;
    CCameraDS* CameraR;
    IplImage* FrameL;
    IplImage* FrameR;
public:
    IplImage* OutImageL;
    IplImage* OutImageR;

    int Width;
    int Height;
};

#endif // BINOCULARCAMERAS_H
