#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{

    setWindowTitle(QStringLiteral("药瓶测量演示程序"));

    BottleHeight=0;
    BottleWidth=0;
    Src=0;
    Mark=0;

//    this->setFixedSize(SHOWWID*2.18, SHOWHEI*1.5);
    centralWidget = new QWidget(this);
    centralWidget->setObjectName(QStringLiteral("centralWidget"));

    //系统名字
    label = new QLabel(this);
    label->setObjectName(QStringLiteral("label"));
    label->setGeometry(QRect(20, 9, 258, 90));
    QString Title=tr("<font color='#5500ff' size='18'>药瓶检测系统</font>");
    label->setText(QStringLiteral("药瓶测量演示程序"));//

    QFont ft;
    ft.setPointSize(18);
    label->setFont(ft);
    QPalette pal;
    pal.setColor(QPalette::WindowText, QColor(0x00,0x00, 0xff,0xFF));
    label->setPalette(pal);
    label->adjustSize();

    //图像显示
    Display1 = new QLabel(this);//centralWidget
    Display1->setObjectName(QStringLiteral("Display1"));
    Display1->setGeometry(QRect(20, 36, SHOWWID,SHOWHEI));

    Display2 = new QLabel(this);
    Display2->setObjectName(QStringLiteral("Display2"));
    Display2->setGeometry(QRect(20+SHOWWID+30, 36, SHOWWID,SHOWHEI));

    DetectBtn = new QPushButton(this);
    DetectBtn->setObjectName(QStringLiteral("DetectBtn"));
    DetectBtn->setGeometry(QRect( SHOWWID*2-36,SHOWHEI+60,80, 23));
    DetectBtn->setText(QStringLiteral("检测下一个"));

    //高度
    NumShow1 = new QLabel(this);
    NumShow1->setObjectName(QStringLiteral("NumShow1"));
    NumShow1->setGeometry(QRect(128, SHOWHEI +50 , 90, 60));
    NumShow1->setText(QStringLiteral("计数"));

    QFont ft1;
    ft1.setPointSize(30);
    NumShow1->setFont(ft1);
    QPalette pal1;
    pal1.setColor(QPalette::WindowText, QColor(0xFF,0x00,0xFF, 0xFF));
    NumShow1->setPalette(pal1);

    //宽度
    NumShow2 = new QLabel(this);
    NumShow2->setObjectName(QStringLiteral("NumShow1"));
    NumShow2->setGeometry(QRect(200+120,  SHOWHEI +50, 90, 60));
    NumShow2->setText(QStringLiteral("计数"));

    QFont ft2;
    ft2.setPointSize(30);
    NumShow2->setFont(ft2);
    QPalette pal2;
    pal2.setColor(QPalette::WindowText, QColor(0xff,0x00,0x00, 0xFF));
    NumShow2->setPalette(pal2);


    //高度
    Hlabel = new QLabel(this);
    Hlabel->setObjectName(QStringLiteral("Hlabel"));
    Hlabel->setGeometry(QRect(28, SHOWHEI +66, 100, 90));

    Hlabel->setText(QStringLiteral("高度(mm)"));//

    ft.setPointSize(18);
    Hlabel->setFont(ft);
    pal.setColor(QPalette::WindowText, QColor(0x00,0x00, 0xff,0xFF));
    Hlabel->setPalette(pal);
    Hlabel->adjustSize();

    //宽度
    Wlabel = new QLabel(this);
    Wlabel->setObjectName(QStringLiteral("Wlabel"));
    Wlabel->setGeometry(QRect(218, SHOWHEI +66, 100, 90));

    Wlabel->setText(QStringLiteral("宽度(mm)"));//

    ft.setPointSize(18);
    Wlabel->setFont(ft);
    pal.setColor(QPalette::WindowText, QColor(0x00,0x00, 0xff,0xFF));
    Wlabel->setPalette(pal);
    Wlabel->adjustSize();


    //图像文件
    FileName="ImageNames.txt";
    PointFileName="LinePoints.txt";

    rsGetStringVector(ImageNames,FileName.c_str());
    rsGetStringVector(PointsStrs,PointFileName.c_str());

    ImageNum=ImageNames.size();

    connect(this,SIGNAL(DisplayImage(QImage,int)),this,SLOT(ImageShow(QImage,int)) );
    connect(DetectBtn,SIGNAL(clicked(bool)),this,SLOT(Next()));

    ImageCount=0;

    UpdateImage();

}

MainWindow::~MainWindow()
{
    if(Src)
    {
        cvReleaseImage(&Src);
        Src=0;
    }
    if(Mark)
    {
        cvReleaseImage(&Mark);
        Mark=0;
    }
}

int MainWindow::ShowImage(IplImage* Image,int Num)
{
    QImage img((uchar*)Image->imageData, Image->width,Image->height, QImage::Format_RGB888);

    emit DisplayImage(img,Num);
    return 0;
}

void MainWindow::ImageShow(QImage img,int Num)
{
    img=img.scaled(QSize(SHOWWID,SHOWHEI));

    if(Num==1)
    {
        Display1->setPixmap(QPixmap::fromImage(img));
    }
    else
    {
        Display2->setPixmap(QPixmap::fromImage(img));
    }
//    cout<<"OK"<<endl;
}

int MainWindow::MarkImage(IplImage*Src,IplImage*Mark,vector<CvPoint>& v) //绘制直线
{
   cvCopyImage(Src,Mark);
   for(int i=0;i<2;i++)
     {
      cvLine(Mark,v[2*i],v[2*i+1],CV_RGB(0,0,255),2);
     }
   for(int i=2;i<4;i++)
     {
      cvLine(Mark,v[2*i],v[2*i+1],CV_RGB(0,255,0),2);
     }
   return 0;
}

int MainWindow::GetLinePoints(string Str,vector<CvPoint> & Points)
{
    int param[16];
    sscanf(Str.c_str(),"line1 : %d, %d, %d, %d, line2 : %d, %d, %d, %d, line3 : %d, %d, %d, %d, line4 : %d, %d, %d, %d, H : %lf, W : %lf"
           ,&param[0],&param[1],&param[2],&param[3],&param[4],&param[5],&param[6],&param[7]
           ,&param[8],&param[9],&param[10],&param[11],&param[12],&param[13],&param[14],&param[15]
           ,&BottleHeight,&BottleWidth);

    for(int i=0;i<8;i++)
    {
        Points[i].x=param[2*i+0];
        Points[i].y=param[2*i+1];
    }

    return 0;
}

int MainWindow::UpdateImage()
{
    if(Src)
    {
        cvReleaseImage(&Src);
    }

    int m=ValMin(ImageCount,ImageNum-1);

    Src=cvLoadImage(ImageNames[m].c_str());

    vector<CvPoint> Points(8);

    GetLinePoints(PointsStrs[m],Points);

    if(!Mark)
    {
        Mark=cvCloneImage(Src);
    }

    MarkImage(Src,Mark,Points);
    ImageCount++;


    ShowImage(Src,1);
    ShowImage(Mark,2);
    ShowCount(BottleHeight,BottleWidth);

    return 0;
}

void MainWindow::Next()
{
    UpdateImage();
}

void MainWindow::ShowCount(double Height,double Width)
{
    NumShow1->setText(QString("%1").arg(Height));
    NumShow2->setText(QString("%1").arg(Width));
}
