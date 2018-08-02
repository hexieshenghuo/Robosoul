#include "MainWindow.h"
#include <QApplication>

#include <QDebug>

#define MAIN        (0)
#define TEST        (1)
#define ALGORITHM   (2)
#define CANNY       (3)
#define HOUGHC      (5)
#define KNNTEST     (6)
#define HOUGHLINE   (7)

#define RUN  0
#if (RUN==MAIN)
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    MainWindow w;
    w.show();

    return a.exec();
}
#elif(RUN==TEST)

int main()
{
    IplImage* Img=cvLoadImage("F:/18.jpg",0);

rsStartTime(T);
    IplImage* Mask=rsGetMaskFromROI(cvSize(200,200),cvRect(0,0,200,200));
T=rsGetTime(T);

    cout<<"Time :"<< T<<" ms"<<endl;
    cvSetImageROI(Img,cvRect(0,0,30,30));

    cvZero(Img);
    CvSize size=cvGetSize(Img);

    cvResetImageROI(Img);

    cvNamedWindow("show");
    cvNamedWindow("mask");

    cvNot(Img,Img);
    cvShowImage("show",Img);
    cvShowImage("mask",Mask);
    cvWaitKey(0);

    cout<<size.width<<" "<<size.height<<endl;

    cvReleaseImage(&Img);
    cvReleaseImage(&Mask);

    return 0;
}

#elif (RUN==KNNTEST)

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);


    float X[100];
    float Y[100];

    rsfor(i,100)
    {
        X[i]=0+i*0.1;
        Y[i]=sin(X[i]);
    }

    CvMat* Data=cvCreateMat(100,1,CV_32FC1);
    CvMat* Label=cvCreateMat(100,1,CV_32FC1);

    cvSetData(Data,X,sizeof(float));
    cvSetData(Label,Y,sizeof(float));

    CvKNearest* knn=new CvKNearest;
    knn->train(Data,Label,0,true);

    CvMat* d=cvCreateMat(1,1,CV_32FC1);

    rsMat32F(d,0,0)=CV_PI/2;

    float res=knn->find_nearest(d,10);

    cout<<res<<endl;

    return a.exec();
}
#elif (RUN==ALGORITHM)

#define ImageName ("F:/RoboSoul/Config/Samples/testgood/g99.jpg");

/* This is a standalone program. Pass an image name as a first parameter of the program.
Switch between standard and probabilistic Hough transform by changing "#if 1" to "#if 0" and back */
#include <cv.h>
#include <highgui.h>
#include <math.h>

int main(int argc, char** argv)
{
    const char* filename = argc >= 2 ? argv[1] : ImageName;//"pic1.png";
    IplImage* src = cvLoadImage( filename, 0 );

    IplImage* gray32=cvCreateImage(cvSize(src->width,src->height),IPL_DEPTH_32F,1);

    IplImage* sub32=cvCreateImage(cvSize(src->width/2,src->height/2),IPL_DEPTH_32F,1);

    cvResize(gray32,sub32);

    cvResize(sub32,gray32);

    cvConvertScale(src,gray32,1.0/255);

    IplImage* dft=cvCloneImage(gray32);

    cvDFT(gray32,dft,CV_DXT_FORWARD);

    cvNamedWindow("dft");
    cvShowImage("dft",dft);
    cvWaitKey(0);

    cvReleaseImage(&src);
    cvReleaseImage(&dft);
    cvReleaseImage(&gray32);

    return 0;
}

#elif (RUN==CANNY)

#ifdef _CH_
#pragma package <opencv>
#endif

#ifndef _EiC
#include "cv.h"
#include "highgui.h"
#endif

char wndname[] = "Edge";
char tbarname[] = "Threshold";
int edge_thresh = 1;

IplImage *image = 0, *cedge = 0, *gray = 0, *edge = 0;

// define a trackbar callback
void on_trackbar(int h)
{
    cvSmooth( gray, edge, CV_BLUR, 3, 3, 0, 0 );
    cvNot( gray, edge );

    // Run the edge detector on grayscale
    cvCanny(gray, edge, (float)edge_thresh, (float)edge_thresh*3, 3);

    cvZero( cedge );
    // copy edge points
    cvCopy( image, cedge, edge );

    cvShowImage(wndname, gray);

}

int main( int argc, char** argv )
{
    char* filename = argc == 2 ? argv[1] : (char*)"F:/21.jpg";

    if( (image = cvLoadImage( filename, 1)) == 0 )
    return -1;

    // Create the output image
    cedge = cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 3);

    // Convert to grayscale
    gray = cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 1);
    edge = cvCreateImage(cvSize(image->width,image->height), IPL_DEPTH_8U, 1);
    cvCvtColor(image, gray, CV_BGR2GRAY);

    cvThreshold(gray,gray,36,255,CV_THRESH_BINARY_INV);//CV_THRESH_TOZERO

//    cvSmooth(gray,gray,CV_GAUSSIAN,3);
//    cvSmooth(gray,gray,CV_GAUSSIAN,3);
//    cvSmooth(gray,gray,CV_GAUSSIAN,3);

//    cvThreshold(gray,gray,100,255,CV_THRESH_BINARY_INV);//CV_THRESH_TOZERO


    // Create a window
    cvNamedWindow(wndname, 1);

    // create a toolbar
    cvCreateTrackbar(tbarname, wndname, &edge_thresh, 100, on_trackbar);

    // Show the image
    on_trackbar(0);

    // Wait for a key stroke; the same function arranges events processing
    cvWaitKey(0);
    cvReleaseImage(&image);
    cvReleaseImage(&gray);
    cvReleaseImage(&edge);
    cvDestroyWindow(wndname);

    return 0;
}

#ifdef _EiC
main(1,"edge.c");
#endif

#elif RUN==HOUGHC
#include <cv.h>
#include <highgui.h>
#include <math.h>

int main(int argc, char** argv)
{
    IplImage* img=cvLoadImage("F:/18.jpg");
        IplImage* gray = cvCreateImage( cvGetSize(img), 8, 1 );
        CvMemStorage* storage = cvCreateMemStorage(0);
        cvCvtColor( img, gray, CV_BGR2GRAY );

//        cvSmooth( gray, gray, CV_GAUSSIAN, 9, 9 ); // smooth it, otherwise a lot of false circles may be detected
        cvThreshold(gray,gray,220,0,CV_THRESH_TOZERO);

//        cvCanny(gray,gray,50,20);

        CvSeq* circles = cvHoughCircles( gray, storage, CV_HOUGH_GRADIENT,1.5, gray->height/4, 100, 30 );
        int i;
        for( i = 0; i < circles->total; i++ )
        {
             float* p = (float*)cvGetSeqElem( circles, i );
             cvCircle( img, cvPoint(cvRound(p[0]),cvRound(p[1])), 3, CV_RGB(0,255,0), -1, 8, 0 );
             cvCircle( img, cvPoint(cvRound(p[0]),cvRound(p[1])), cvRound(p[2]), CV_RGB(255,0,0), 3, 8, 0 );
        }
        cvNamedWindow( "circles", 1 );
        cvShowImage( "circles", gray );

        cvNamedWindow( "show" );
        cvShowImage( "show", img );
        cvWaitKey(0);



    return 0;
}

#elif (RUN==HOUGHLINE)
/* This is a standalone program. Pass an image name as a first parameter of the program.
Switch between standard and probabilistic Hough transform by changing "#if 1" to "#if 0" and back */
#include <cv.h>
#include <highgui.h>
#include <math.h>

int main(int argc, char** argv)
{
    const char* filename = argc >= 2 ? argv[1] : "F:/18.jpg";
    IplImage* src = cvLoadImage( filename, 0 );
    IplImage* dst;
    IplImage* color_dst;
    CvMemStorage* storage = cvCreateMemStorage(0);
    CvSeq* lines = 0;
    int i;

    if( !src )
    return -1;

//    cvThreshold(src,src,50,255,CV_THRESH_BINARY);CV_THRESH_TOZERO;

    double scale =3;
    IplImage* S=cvCreateImage(cvSize(src->width/scale,src->height/scale),8,1);

    cvResize(src,S);

    dst = cvCreateImage( cvGetSize(src), 8, 1 );
    color_dst = cvCreateImage( cvGetSize(src), 8, 3 );

    cvCanny( src, dst, 30, 220, 3 );
//    cvCanny( src, src, 30, 200, 3 );
    cvCvtColor( src, color_dst, CV_GRAY2BGR );
    #if 0
    lines = cvHoughLines2( dst, storage, CV_HOUGH_STANDARD, 1, CV_PI/180, 100, 0, 0 );

    for( i = 0; i < MIN(lines->total,100); i++ )
    {
        float* line = (float*)cvGetSeqElem(lines,i);
        float rho = line[0];
        float theta = line[1];
        CvPoint pt1, pt2;
        double a = cos(theta), b = sin(theta);
        double x0 = a*rho, y0 = b*rho;
        pt1.x = cvRound(x0 + 1000*(-b));
        pt1.y = cvRound(y0 + 1000*(a));
        pt2.x = cvRound(x0 - 1000*(-b));
        pt2.y = cvRound(y0 - 1000*(a));
        cvLine( color_dst, pt1, pt2, CV_RGB(255,0,0), 1, CV_AA, 0 );
    }
    #else
    lines = cvHoughLines2( dst, storage, CV_HOUGH_PROBABILISTIC, 1, CV_PI/180, 10, 20, 60 );
    for( i = 0; i < lines->total; i++ )
    {
        CvPoint* line = (CvPoint*)cvGetSeqElem(lines,i);
        cvLine( color_dst, line[0], line[1], CV_RGB(255,0,0), 1, CV_AA, 0 );
    }
    #endif
    cvNamedWindow( "Source", 1 );
    cvShowImage( "Source", src );

    cvNamedWindow( "Hough", 1 );
    cvShowImage( "Hough", color_dst );

    cvWaitKey(0);

    return 0;
}


#endif
