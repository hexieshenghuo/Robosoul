#include "MainWindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    this->setFixedSize(690, 460);
    centralWidget = new QWidget(this);
    centralWidget->setObjectName(QStringLiteral("centralWidget"));

    //系统名字
    label = new QLabel(centralWidget);
    label->setObjectName(QStringLiteral("label"));
    label->setGeometry(QRect(20, 10, 258, 31));
    QString Title=tr("<font color='#5500ff' size='18'>药瓶检测系统</font>");
//    label->setText(QStringLiteral("检测系统"));
    QFont ft;
    ft.setPointSize(18);
    label->setFont(ft);
    QPalette pal;
    pal.setColor(QPalette::WindowText, QColor(0x00,0x00, 0xff,0xFF));
    label->setPalette(pal);

    //Good计数
    NumShow1 = new QLabel(centralWidget);
    NumShow1->setObjectName(QStringLiteral("NumShow1"));
    NumShow1->setGeometry(QRect(360, 60, 258, 60));
//    NumShow1->setText(QStringLiteral("计数"));

    QFont ft1;
    ft1.setPointSize(30);
    NumShow1->setFont(ft1);
    QPalette pal1;
    pal1.setColor(QPalette::WindowText, QColor(0xFF,0x00,0xFF, 0xFF));
    NumShow1->setPalette(pal1);

    //Bad计数
    NumShow2 = new QLabel(centralWidget);
    NumShow2->setObjectName(QStringLiteral("NumShow1"));
    NumShow2->setGeometry(QRect(360, 180, 258, 60));
//    NumShow2->setText(QStringLiteral("计数"));

    QFont ft2;
    ft2.setPointSize(30);
    NumShow2->setFont(ft2);
    QPalette pal2;
    pal2.setColor(QPalette::WindowText, QColor(0xff,0x00,0x00, 0xFF));
    NumShow2->setPalette(pal2);

    //图像显示
    Display = new QLabel(centralWidget);
    Display->setObjectName(QStringLiteral("Display"));
    Display->setGeometry(QRect(20, 50, 320, 240));

    RunningInfor = new QTextEdit(centralWidget);
    RunningInfor->setObjectName(QStringLiteral("RunningInfor"));
    RunningInfor->setGeometry(QRect(10, 300, 481, 101));
    RunningInfor->append("God Bless Us! Come On!");

    groupBox = new QGroupBox(centralWidget);
    groupBox->setObjectName(QStringLiteral("groupBox"));
    groupBox->setGeometry(QRect(580, 50, 101, 211));
    groupBox->setTitle(QStringLiteral("在线功能"));

    DetectBtn = new QPushButton(groupBox);
    DetectBtn->setObjectName(QStringLiteral("DetectBtn"));
    DetectBtn->setGeometry(QRect(10, 20, 80, 23));
    DetectBtn->setText(QStringLiteral("检测"));

    GetBack = new QPushButton(groupBox);
    GetBack->setObjectName(QStringLiteral("GetBack"));
    GetBack->setGeometry(QRect(10, 50, 80, 23));
    GetBack->setText(QStringLiteral("背景生成"));

    AutoControlBtn = new QPushButton(groupBox);
    AutoControlBtn->setObjectName(QStringLiteral("AutoControlBtn"));
    AutoControlBtn->setGeometry(QRect(10, 160, 80, 23));
    AutoControlBtn->setText(QStringLiteral("全自动"));

    MotorTest = new QPushButton(groupBox);
    MotorTest->setObjectName(QStringLiteral("MotorTest"));
    MotorTest->setGeometry(QRect(10, 80, 80, 23));
    MotorTest->setText(QStringLiteral("电机测试"));

    P = new QRadioButton(groupBox);
    P->setObjectName(QStringLiteral("P"));
    P->setGeometry(QRect(10, 140, 39, 16));
    P->setText(QStringLiteral("正"));


    N = new QRadioButton(groupBox);
    N->setObjectName(QStringLiteral("N"));
    N->setGeometry(QRect(50, 140, 39, 16));
    N->setText(QStringLiteral("负"));

    TrainSampleCap=new QPushButton(groupBox);
    TrainSampleCap->setObjectName(QStringLiteral("TrainSampleCap"));
    TrainSampleCap->setGeometry(QRect(10, 110, 80, 23));
    TrainSampleCap->setText(QStringLiteral("训练样本采集"));


    Stop=new QPushButton(groupBox);
    Stop->setObjectName(QStringLiteral("Stop"));
    Stop->setGeometry(QRect(10, 186, 80, 23));
    Stop->setText(QStringLiteral("停止"));

    groupBox_2 = new QGroupBox(centralWidget);
    groupBox_2->setObjectName(QStringLiteral("groupBox_2"));
    groupBox_2->setGeometry(QRect(580, 270, 100, 180));
    groupBox_2->setTitle(QStringLiteral("离线功能"));

    TrainBtn = new QPushButton(groupBox_2);
    TrainBtn->setObjectName(QStringLiteral("TrainBtn"));
    TrainBtn->setGeometry(QRect(10, 20, 80, 23));
    TrainBtn->setText(QStringLiteral("训练"));

    TestBtn = new QPushButton(groupBox_2);
    TestBtn->setObjectName(QStringLiteral("TestBtn"));
    TestBtn->setGeometry(QRect(10, 43, 80, 23));
    TestBtn->setText(QStringLiteral("测试"));


    UpdateDetector = new QPushButton(groupBox_2);
    UpdateDetector->setObjectName(QStringLiteral("UpdateDetector"));
    UpdateDetector->setGeometry(QRect(10, 96, 80, 23));
    UpdateDetector->setText(QStringLiteral("更新"));


    ComboBox = new QComboBox(groupBox_2);
    ComboBox->setObjectName(QStringLiteral("ComboBox"));
    ComboBox->setGeometry(QRect(10, 70, 80, 23));

    this->setCentralWidget(centralWidget);
    menuBar = new QMenuBar(this);
    menuBar->setObjectName(QStringLiteral("menuBar"));
    menuBar->setGeometry(QRect(0, 0, 622, 23));
    this->setMenuBar(menuBar);
    mainToolBar = new QToolBar(this);
    mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
    this->addToolBar(Qt::TopToolBarArea, mainToolBar);
    statusBar = new QStatusBar(this);
    statusBar->setObjectName(QStringLiteral("statusBar"));
    this->setStatusBar(statusBar);

    detector=0;
    detector=new Detector(this);

    rsfor(i,detector->CateNum)
    {
        ComboBox->addItem(QString("Cate%1").arg(i));
    }
    ComboBox->addItem("All Cates");
    ComboBox->setCurrentIndex(detector->CateNum);

    //---------信号连接
    connect(detector,SIGNAL(ShowMessage(QString)),this,SLOT(UpdateMessage(QString)));//
    connect(this,SIGNAL(ShowMessage(QString)),this,SLOT(UpdateMessage(QString)));
    connect(AutoControlBtn,SIGNAL(clicked(bool)),this,SLOT(Auto()));
    connect(Stop,SIGNAL(clicked(bool)),this,SLOT(TaskStop()));
    connect(detector,SIGNAL(Display(QImage)),this,SLOT(ImageShow(QImage)));//
    connect(GetBack,SIGNAL(clicked(bool)),this,SLOT(CreateBack()));
    connect(TrainSampleCap,SIGNAL(clicked(bool)),this,SLOT(TrainSample()));
    connect(MotorTest,SIGNAL(clicked(bool)),this,SLOT(MotorAction()));
    connect(P,SIGNAL(toggled(bool)),this,SLOT(TypeChanged()));
    connect(TrainBtn,SIGNAL(clicked(bool)),this,SLOT(Train()));//离线
    connect(DetectBtn,SIGNAL(clicked(bool)),this,SLOT(Detect()));
    connect(TestBtn,SIGNAL(clicked(bool)),this,SLOT(Test()));//离线
    connect(ComboBox,SIGNAL(currentIndexChanged(int)),this,SLOT(ComboBoxProc(int)));

    connect(detector,SIGNAL(ShowCount(int,int)),this,SLOT(ShowCount(int,int)));
    connect(UpdateDetector,SIGNAL(clicked(bool)),this,SLOT(updateDetector()));

//    emit detector->ShowCount(999,666);

    //--------串口
    ComNameFileName="F:/RoboSoul/Config/ComName.rsc";
    motor =new Motor(this);
    motor->Open((char*)ComNameFileName.c_str());
    connect(motor,SIGNAL(ShowMessage(QString)),this,SLOT(UpdateMessage(QString)));
    connect(detector,SIGNAL(Clean(long)),motor,SLOT(Clean(long)));

    detector->start();
}

MainWindow::~MainWindow()
{
    if(detector)
    {
        delete detector;
        detector=0;
    }
}

void MainWindow::UpdateMessage(QString Str)
{
    RunningInfor->append(Str);
}

void MainWindow::MotorAction()
{
    RunningInfor->append("MotorAction");
    motor->SendCommand();
}

void MainWindow::Auto()
{
    detector->Task=OFF;
    detector->TaskID=AUTO;
    detector->Task=ON;
}

void MainWindow::TaskStop()
{
    detector->Task=OFF;
}

void MainWindow::CreateBack()
{
    detector->Task=OFF;
    detector->TaskID=BACKGROUND;
    detector->Task=ON;
}

void MainWindow::ImageShow(QImage img)
{
    img=img.scaled(QSize(SHOWWID,SHOWHEI));
    Display->setPixmap(QPixmap::fromImage(img));
}

void MainWindow::TypeChanged()
{
    if(P->isChecked())
    {
        detector->SampleType=(int)RSGOOD;
    }
    if(N->isChecked())
    {
        detector->SampleType=(int)RSBAD;
    }
    ShowMessage(QString("SampleType is %0").arg(detector->SampleType) );
}

void MainWindow::TrainSample()
{
    detector->Task=OFF;
    detector->TaskID=OBJDETECT;
    detector->Task=ON;
}

void MainWindow::Train()
{
    ShowMessage("Train......");
    detector->Task=OFF;
    detector->TaskID=TRAIN;
    detector->Task=ON;
}

void MainWindow::Detect()
{
    detector->Task=OFF;
    detector->TaskID=CONTROL;
    detector->Task=ON;
}

void MainWindow::Test()
{
    detector->Task=OFF;
    detector->TaskID=TEST;
    detector->Task=ON;
}

void MainWindow::ComboBoxProc(int Index)
{
    detector->TrainNo=Index;
//    qDebug()<<ComboBox->currentText();
    ShowMessage(QString("TrainNO is %1").arg(Index));
}

void MainWindow::ShowCount(int good,int bad)
{
    NumShow1->setText(QString("Good:%1").arg(good));
    NumShow2->setText(QString("Bad :%1").arg(bad));
}

void MainWindow::updateDetector()
{
    //delete detector 有问题!
    ShowMessage("UpdateModel......");
    detector->Task=OFF;
    detector->TaskID=UPDATEMODEL;
    detector->Task=ON;
}
