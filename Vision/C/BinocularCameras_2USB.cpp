#include "BinocularCameras_2USB.h"

BinocularCameras::BinocularCameras()
{
    //获得Camera ID
    CameraID_L=RS_CAMERA_ID_L;
    CameraID_R=RS_CAMERA_ID_R;

    //初始化图像指针
    CaptureL=0;
    CaptureR=0;
    FrameL=0;
    FrameR=0;
    OutImageL=0;
    OutImageR=0;
}

int BinocularCameras::Open(int CameraID_L,int CameraID_R)
{
    CaptureL= cvCreateCameraCapture(CameraID_L);
    CaptureR= cvCreateCameraCapture(CameraID_R);

    int L=(CaptureL==0?0:1);
    int R=(CaptureR==0?0:1);

    int Res=L<<0 | R<<1;

    return Res;
}

//CameraImageInfor BinocularCameras::GetCameraImageInfor(IplImage* Image)
//{
//    CameraImageInfor ImageInfor;
//    ImageInfor.Size=cvGetSize(Image);
//    ImageInfor.Channel=Image->nChannels;
//    ImageInfor.Depth=Image->depth;
//    return ImageInfor;
//}

int BinocularCameras::CreateOutImage(IplImage* Frame,int LorR)
{
    if(!Frame)
    {
        return -1;
    }
    switch (LorR) {
    case RS_CAMERA_ID_L:
        OutImageL=cvCreateImage(cvSize(Frame->width,Frame->height),Frame->depth,Frame->nChannels);
        break;
    case RS_CAMERA_ID_R:
        OutImageR=cvCreateImage(cvSize(Frame->width,Frame->height),Frame->depth,Frame->nChannels);
        break;
    default:
        return -1;
    }


    return 0;
}

int BinocularCameras::GetImages()
{
    FrameL=cvQueryFrame( CaptureL );
    FrameR=cvQueryFrame( CaptureR );

    if(FrameL)
    {
        cvCopyImage(FrameL,OutImageL);
    }

    if(FrameR)
    {
        cvCopyImage(FrameR,OutImageR);
    }
    return 0;
}


int BinocularCameras::Close()
{
    if(CaptureL)
    {
        cvReleaseCapture(&CaptureL);
        CaptureL=0;
    }
    if(CaptureR)
    {
        cvReleaseCapture(&CaptureR);
        CaptureR=0;
    }
    if(OutImageL)
    {
        cvReleaseImage(&OutImageL);
        OutImageL=0;
    }
    if(OutImageR)
    {
        cvReleaseImage(&OutImageR);
        OutImageR=0;
    }
    return 0;
}

int BinocularCameras::GetFirstFrame()
{
    if(!CaptureL || !CaptureR)
    {
        return -1;
    }
    FrameL=cvQueryFrame( CaptureL );
    FrameR=cvQueryFrame( CaptureR );

    return 0;
}
