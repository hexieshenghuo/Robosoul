#include <iostream>
#include<Kinect.h>
#include <highgui.h>
using namespace std;

int main()
{
    Kinect kinect;
    IplImage* ColorImage=kinect.CreateKinectRGBImage();

    IplImage* DepthImage=kinect.CreateKinectDepthImage();

    cvNamedWindow("Color");
    cvNamedWindow("Depth");

    for (;;)
    {
        int res=kinect.GetImageData(DepthImage,ColorImage);
        cvConvertScale(DepthImage,DepthImage,10);
        cout<<res<<endl;
        cvShowImage("Color",ColorImage);
        cvShowImage("Depth",DepthImage);
        cvWaitKey(30);
    }

    cvReleaseImage(&ColorImage);
    cvReleaseImage(&DepthImage);

}
