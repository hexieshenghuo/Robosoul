#include "BinocularCameras.h"

BinocularCameras::BinocularCameras()
{

    CameraL=new CCameraDS;
    CameraR=new CCameraDS;

    OutImageL=0;
    OutImageR=0;

    FrameL=0;
    FrameR=0;

    Width=RS_BI_WIDTH;
    Height=RS_BI_HEIGHT;
}

int BinocularCameras::Open(int Camera_ID_L,int Camera_ID_R)
{
    int CamCount=CCameraDS::CameraCount();
    if (CamCount<2)
    {
        return RS_ERROR;
    }

//    int L= CameraL->OpenCamera(Camera_ID_L,false,Width,Height);
//    int R= CameraR->OpenCamera(Camera_ID_R,false,Width,Height);

        int L= CameraL->OpenCamera(Camera_ID_L,false);
        int R= CameraR->OpenCamera(Camera_ID_R,false);


    int Res= L<<0 | R<<1;
    return Res;
}

int BinocularCameras::CreateOutImage()
{
    if(OutImageL || OutImageR)
    {
        return RS_ERROR;
    }

    OutImageL=cvCreateImage(cvSize(Width,Height), IPL_DEPTH_8U, 3);
    OutImageR=cvCreateImage(cvSize(Width,Height), IPL_DEPTH_8U, 3);
    return RS_SUCCESS;
}


int BinocularCameras::Close()
{
    if(CameraL)
    {
        CameraL->CloseCamera();
        delete CameraL;
        CameraL=0;
    }

    if(CameraR)
    {
        CameraR->CloseCamera();
        delete CameraR;
        CameraR=0;
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
    return RS_SUCCESS;
}

int BinocularCameras::UpdateOutImage()
{
    FrameL=CameraL->QueryFrame();
    FrameR=CameraR->QueryFrame();
    cvCopyImage(FrameL,OutImageL);
    cvCopyImage(FrameR,OutImageR);
    return RS_SUCCESS;
}
