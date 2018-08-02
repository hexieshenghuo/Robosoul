#include "Camera.h"

Camera::Camera()
{
    queryImage=0;//该句存在进程退出异常
//    queryImage=cvCreateImage(cvSize(IMGWID,IMGHEI),IPL_DEPTH_8U,3);

    CameraSource=RSSOURCE;
    Capture=0;
    IsOpen=false;
    Index=0;
    Len=0;
    Width=0;
    Height=0;
    Data=0;

    ErrorCode=0;
}
Camera::~Camera()
{
    Close();

    if(queryImage)
    {
        cvReleaseImage(&queryImage);
        queryImage=0;
    }

    if(Data)
    {
        delete[] Data;
        Data=0;
    }

    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }
}

int Camera::Open(int ID)
{
    switch (CameraSource)
    {
    case USBCAM:
        if(!Capture)
        {
            Capture= cvCreateCameraCapture(ID);
            IsOpen=true;
        }
        return (Capture==0)?(RS_ERROR):(RS_OK);
        break;
    case INDUSSDK:
#if (RSSOURCE==INDUSSDK)
        CameraInit(Index);

        int count;
        CameraGetCount(&count);
        for(int i=0; i<count; i++)
        {
            char name[255], model[255];
            CameraGetName(i, name, model);
        }
        CameraSetResolution(Index,RESL,&Width,&Height);
        CameraGetImageSize(Index,&Width, &Height);
        CameraGetImageBufferSize(Index,&Len, CAMERA_IMAGE_RGB24);

        if(Width==0 ||Height==0)
        {
            cout<<"Width Or Height is 0......"<<endl;
            return RS_ERROR;
        }

        if(!Data)
        {
             Data=new uchar[Len];
        }
        if(!queryImage)
        {
            queryImage=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
        }

        IsOpen=true;
#endif
        break;
    default:
        return RS_ERROR;
        break;
    }
    return RS_OK;
}

IplImage* Camera::QueryImage()
{
#if (RSSOURCE==USBCAM)
    return cvQueryFrame(Capture);
#else
    // INDUSSDK
    if(CameraQueryImage(Index,Data, &Len,CAMERA_IMAGE_RGB24)==API_OK)//CAMERA_IMAGE_RGB24
    {
       memcpy(queryImage->imageData,Data,Len*sizeof(uchar));
    }
    else
    {
cout<<"QueryImage() Error..."<<"Length: "<<Len<<endl;
        CameraGetLastError(&ErrorCode);
cout<<"Error Code is "<<ErrorCode<<endl;
        return 0;
    }
    return queryImage;
#endif
}

IplImage* Camera::QueryImage(uchar** Data)
{
    IplImage* Image=0;
    CameraGetImageSize(Index,&Width, &Height);
    CameraGetImageBufferSize(Index,&Len, CAMERA_IMAGE_RGB24);//

    Data[0] = new unsigned char[Len];

    if(CameraQueryImage(Index,Data[0], &Len,CAMERA_IMAGE_RGB24)==API_OK)//CAMERA_IMAGE_RGB24
    {
       Image=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
       memcpy(Image->imageData,Data[0],Len*sizeof(uchar));
    }
    return Image;
}

int Camera::Close()
{
#if (RSSOURCE==USBCAM)
    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }
#else
    int res= CameraFree(Index);
#endif

    IsOpen=false;

    return res;
}

int Camera::ReStart()
{
   if(API_OK==Close())//free
   {
cout<<"Open()......"<<endl;
      if(RS_OK==Open(Index))
      {
          return RS_OK;
      }
      else
      {
cout<<"Run CameraReset()......"<<endl;
          return (API_OK==CameraReset(Index))?RS_OK:RS_ERROR;
      }
   }
   else
   {
cout<<"Run CameraReconnect()......"<<endl;
       if(API_OK==CameraReconnect(Index))
       {
cout<<"Open()......"<<endl;
           return Open(Index);
       }
       else
       {
           return RS_ERROR;
       }
   }

   return 0;
}
