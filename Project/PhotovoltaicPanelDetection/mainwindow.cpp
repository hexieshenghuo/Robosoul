#include "mainwindow.h"

#include <QDebug>
#include <QString>
#include <QFileDialog>
#include <QFileInfo>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{

#if(1)

#endif

//    this->setFixedSize(690, 399);
    this->resize(790, 500);
    centralWidget = new QWidget(this);
    centralWidget->setObjectName(QStringLiteral("centralWidget"));
    this->setCentralWidget(centralWidget);

    // 菜单与工具栏
    menuBar = new QMenuBar(this);
    menuBar->setObjectName(QStringLiteral("menuBar"));
    menuBar->setGeometry(QRect(0, 0, 599, 23));
    this->setMenuBar(menuBar);

    mainToolBar = new QToolBar(this);
    mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
    this->addToolBar(Qt::TopToolBarArea, mainToolBar);

    //系统名字
    label = new QLabel(centralWidget);
    label->setObjectName(QStringLiteral("label"));
    label->setGeometry(QRect(20, 0, 298, 52));

    QString Title=tr("<font color='#5500ff' size='18'></font>");
    label->setText(QStringLiteral("光伏板检测系统-v1.2"));
    QFont ft;
    ft.setPointSize(18);
    label->setFont(ft);
    QPalette pal;
    pal.setColor(QPalette::WindowText, QColor(0x00,0x00, 0xff,0xFF));
    label->setPalette(pal);

    //程序运行信息显示
    RunningInfor = new QTextEdit(centralWidget);
    RunningInfor->setObjectName(QStringLiteral("RunningInfor"));
    RunningInfor->setGeometry(QRect(10, 300, 369, 180));

    // 功能1
    groupBox1 = new QGroupBox(centralWidget);
    groupBox1->setObjectName(QStringLiteral("groupBox1"));
    groupBox1->setGeometry(QRect(390, 36, 180, 258));
    groupBox1->setTitle(QStringLiteral("功能"));

    StartDetect=new QPushButton(groupBox1);
    StartDetect->setObjectName(QStringLiteral("StartThread"));
    StartDetect->setGeometry(QRect(10, 18, 60, 28));
    StartDetect->setText(QStringLiteral("启动检测"));

    StartStitch=new QPushButton(groupBox1);
    StartStitch->setObjectName(QStringLiteral("StartStitch"));
    StartStitch->setGeometry(QRect(10, 50, 60, 28));
    StartStitch->setText(QStringLiteral("启动拼接"));

    StopThread=new QPushButton(groupBox1);
    StopThread->setObjectName(QStringLiteral("StopThread"));
    StopThread->setGeometry(QRect(10, 80, 60, 28));
    StopThread->setText(QStringLiteral("停止"));

    UpdateSpotInfor=new QPushButton(groupBox1);
    UpdateSpotInfor->setObjectName(QStringLiteral("UpdateSpotInfor"));
    UpdateSpotInfor->setGeometry(QRect(10,112,60,28));
    UpdateSpotInfor->setText(QStringLiteral("热斑信息"));

    // 参数设置
    groupBox2 = new QGroupBox(centralWidget);
    groupBox2->setObjectName(QStringLiteral("groupBox2"));
    groupBox2->setGeometry(QRect(600, 36, 180, 258));
    groupBox2->setTitle(QStringLiteral("参数设置"));

    P = new QRadioButton(groupBox2);
    P->setObjectName(QStringLiteral("P"));
    P->setGeometry(QRect(10, 16 , 172, 16));
    P->setText(QStringLiteral("起始视频方向:→"));

    N = new QRadioButton(groupBox2);
    N->setObjectName(QStringLiteral("N"));
    N->setGeometry(QRect(10, 36, 172, 16));
    N->setText(QStringLiteral("起始视频方向:←"));

    IntervalLabel=new QLabel(groupBox2);
    IntervalLabel->setObjectName(QStringLiteral("IntervalLabel"));
    IntervalLabel->setGeometry(QRect(10,60,60,18));
    IntervalLabel->setText(QStringLiteral("视频间隔"));

    IntervalBox=new QComboBox(groupBox2);
    IntervalBox->move(80,60);
    IntervalBox->setObjectName(QStringLiteral("IntervalBox"));
    IntervalBox->addItem("1",0);
    IntervalBox->addItem("2",1);
    IntervalBox->addItem("3",2);
    IntervalBox->addItem("4",3);
    IntervalBox->addItem("5",4);
    IntervalBox->addItem("6",5);
    IntervalBox->addItem("7",6);
    IntervalBox->addItem("8",7);
    IntervalBox->addItem("9",8);

    // 数据表
    groupBox3 = new QGroupBox(centralWidget);
    groupBox3->setObjectName(QStringLiteral("groupBox3"));
    groupBox3->setGeometry(QRect(390, 300, 390, 180));
    groupBox3->setTitle(QStringLiteral("数据"));

    // 数据表
    Table=new QTableWidget(groupBox3);
    Table->setGeometry(12,18,369,158);
//    Table->setColumnCount(7);
//    Table->setRowCount(500);


    // 图像显示
    Display = new QLabel(centralWidget);
    Display->setObjectName(QStringLiteral("Display"));
    Display->setGeometry(QRect(20, 50, 360, 240));


    // 检测功能初始化
    detector=0;
    detector=new pvDetector(this);
    detector->FilePath="./DetectVideos";

    IntervalBox->setCurrentIndex(detector->FrameInterval-1);


    // 信号与槽连接
    connect(detector,SIGNAL(Display(QImage)),this,SLOT(ImageShow(QImage)));
    connect(detector,SIGNAL(ShowMessage(QString)),this,SLOT(ShowMessage(QString)));
    connect(this,SIGNAL(SendMessage(QString)),this,SLOT(ShowMessage(QString)));
    connect(P,SIGNAL(toggled(bool)),this,SLOT(TypeChanged()));
    connect(StartDetect,SIGNAL(clicked(bool)),this,SLOT(onStartDetect()));
    connect(StartStitch,SIGNAL(clicked(bool)),this,SLOT(onStartStitch()));
    connect(StopThread,SIGNAL(clicked(bool)),this,SLOT(onStopThread()));
    connect(detector,SIGNAL(ClearMessage()),RunningInfor,SLOT(clear()));
    connect(IntervalBox,SIGNAL(currentIndexChanged(int)),SLOT(onIntervalBox(int )));
    connect(UpdateSpotInfor,SIGNAL(clicked(bool)),SLOT(onUpdateSpotInfor()));

    // 启动信息
    RunningInfor->append(QStringLiteral("系统启动......"));
    RunningInfor->append(QStringLiteral("系统版本: %1......").arg(1.2));
    SendMessage(QStringLiteral("待检测视频文件路径为:"));
    SendMessage(QString::fromLocal8Bit(detector->FilePath.c_str()));

    if(detector->VideoNames.size()==0)
    {
        SendMessage(QStringLiteral("默认视频路径无mp4视频文件"));
    }

    QImage img;
    if(true==img.load("Show.jpg"))
    {
        detector->Display(img);
    }

    for(int i=0;i<detector->VideoNames.size();i++)
    {
        SendMessage(QString::fromLocal8Bit(detector->VideoNames[i].c_str()));
    }

}

MainWindow::~MainWindow()
{

}

void MainWindow::ImageShow(QImage img)
{
    img=img.scaled(QSize(SHOWWID,SHOWHEI));
    Display->setPixmap(QPixmap::fromImage(img));
}

void MainWindow::ShowMessage(QString Str)
{
    RunningInfor->append(Str);
}


void MainWindow::TypeChanged()
{
    if(P->isChecked())
    {
        detector->StartFlag=0;// →
        SendMessage(QStringLiteral("起始视频方向变为从左至右"));

    }
    if(N->isChecked())
    {
        detector->StartFlag=1;// ←
        SendMessage(QStringLiteral("起始视频方向变为从右至左"));
    }

    SendMessage(QStringLiteral("StartFlag: %1").arg(detector->StartFlag));
}

void MainWindow::onStartDetect()
{
    detector->RunCommand=PV_DETECT;
    if(detector->cmdThreadStop==1)
    {
        detector->cmdThreadStop=0;
        detector->start();
    }
}

void MainWindow::onStartStitch()
{
    detector->RunCommand=PV_STITCH;

    QString file_full = QFileDialog::getOpenFileName(this);
    QFileInfo fi= QFileInfo(file_full);
    QString  Str=fi.absoluteFilePath();
    QString FileName=fi.fileName();

    if (0==FileName.size())
    {
        SendMessage(QStringLiteral("没找到合法文件......"));
        return;
    }

    detector->StitchFileName = Str.toLatin1(); // must

    if(detector->cmdThreadStop==1)
    {
        detector->cmdThreadStop=0;
        detector->start();
    }
}


void MainWindow::onIntervalBox(int Index)
{
    detector->FrameInterval=Index+1;
    SendMessage(QStringLiteral("视频抽帧间隔变为: %1").arg(Index+1));
}

void MainWindow::onStopThread()
{
    detector->cmdThreadStop=1;
    detector->ThreadOn=0;
    detector->RunCommand=PV_NOTHING;
}

void MainWindow::onUpdateSpotInfor()
{
    if(0==detector->TotalHeatSpotInfor.size())
    {
        SendMessage(QStringLiteral("暂时无热斑信息......"));
        return;
    }
    //行、列数
    Table->setRowCount(detector->TotalHeatSpotInfor.size());
    Table->setColumnCount(7);

    //列标题
    QStringList headers;
    headers<<"Param.x"<<"Param.y"<<"Param.Radius"<<"src"<<" FramePos"<<"row"<<"col";
    Table->setHorizontalHeaderLabels(headers);
    Table->horizontalHeader()->setDefaultAlignment(Qt::AlignLeft);//对齐方式

    //行标题
//    rowLabels << "Info0" << "Info1" << "Info2"<< "Info3" << "Info4" << "Info5"<< "Info6" << "Info7" << "Info8"<< "Info9" << "Info10"<< "Info11"
//                 << "Info12" << "Info13" << "Info14"<< "Info15" << "Info16" << "Info17"<< "Info18" << "Info19" << "Info20"<< "Info21" << "Info22" << "Info23"
//                    << "Info24" << "Info25" << "Info26"<< "Info27" << "Info28" << "Info29";
//    Table->setVerticalHeaderLabels(rowLabels);

    //自动调整最后一列的宽度使它和表格的右边界对齐
    Table->horizontalHeader()->setStretchLastSection(true);

    //表格的选择方式
    Table->setSelectionBehavior(QAbstractItemView::SelectItems);

    //禁止编辑
    Table->setEditTriggers(QAbstractItemView::NoEditTriggers);

    for(int i=0;i<7;i++)
    {
        Table->setColumnWidth(i,60);//列宽
    }

    for(int i=0;i<detector->TotalHeatSpotInfor.size();i++)
    {
           Table->setRowHeight(i,50);//行高
           QTableWidgetItem* item0=new QTableWidgetItem;
           QTableWidgetItem* item1=new QTableWidgetItem;
           QTableWidgetItem* item2=new QTableWidgetItem;
           QTableWidgetItem* item3=new QTableWidgetItem;
           QTableWidgetItem* item4=new QTableWidgetItem;
           QTableWidgetItem* item5=new QTableWidgetItem;
           QTableWidgetItem* item6=new QTableWidgetItem;

           item0->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].x));
           Table->setItem(i,0,item0);

           item1->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].y));
           Table->setItem(i,1,item1);

           item2->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].Radius));
           Table->setItem(i,2,item2);

           item3->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].ID));
           Table->setItem(i,3,item3);

           item4->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].Pos));
           Table->setItem(i,4,item4);

           item5->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].Row));
           Table->setItem(i,5,item5);

           item6->setText(QString("%1").arg(detector->TotalHeatSpotInfor[i].Col));
           Table->setItem(i,6,item6);
    }

    connect(Table,SIGNAL(cellDoubleClicked(int,int)),this,SLOT(Retrieval(int,int)));
    return;
}


void MainWindow::Retrieval(int Row,int Col)
{
    HeatSpotParam hsp=detector->TotalHeatSpotInfor[Row];

    CvCapture*Capture=cvCaptureFromAVI(detector->VideoNames[hsp.ID].c_str());
    cvSetCaptureProperty(Capture,CV_CAP_PROP_POS_FRAMES,hsp.Pos);

    //
    IplImage* Temp=cvQueryFrame(Capture);
    cvCvtColor(Temp, Temp, CV_BGR2RGB);
    detector->ShowImage(Temp);

    if(Capture)
    {
        cvReleaseCapture(&Capture);
        Capture=0;
    }


    return;
}
