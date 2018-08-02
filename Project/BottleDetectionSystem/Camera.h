#ifndef CAMERA_H
#define CAMERA_H

#include<BasicOperation.h>

#define   USBCAM      (1)
#define   INDUSSDK    (2)

#define RSSOURCE    INDUSSDK   //   USBCAM   //
#define RESL          (5)      // 5:800×600 6:640×480

#if (RSSOURCE==USBCAM)
#include <highgui.h>
#elif(RSSOURCE==INDUSSDK)
#include <JHCap.h>
#include "Windows.h"
#endif

#define IMGWID          (800)
#define IMGHEI          (600)


class Camera
{
public:
    Camera();
    ~Camera();

    //USB Camera Based on OpenCV
    int CameraSource;
    CvCapture* Capture;

    //Indus SDK
    int Index;
    int Len;
    int Width;
    int Height;
    uchar* Data;
    IplImage* queryImage;
    IplImage* QueryImage();
    IplImage* QueryImage(uchar **Data);
    int ErrorCode;   //错误代码!

    bool IsOpen;
    int Open(int ID=(CV_CAP_DSHOW+0));
    int Close();

    int ReStart();
};

#endif // CAMERA_H
