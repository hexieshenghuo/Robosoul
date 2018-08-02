#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QGroupBox>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QWidget>
#include <QComboBox>
#include <QFont>
#include <QPalette>
#include <QString>
#include <QTextCodec>
#include <QImage>
#include <QRadioButton>

#include<BasicOperation.h>
#include<FileOper.h>


#define SHOWWID       (400)
#define SHOWHEI       (300)

#define ValMin(a,b)   ( (a)<(b)?(a):(b) )

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

    //---------界面控件
    QWidget *centralWidget;
    QLabel *label;
    QLabel *Wlabel;   //"宽度"
    QLabel *Hlabel;   //"高度"
    QLabel * NumShow1;   //Good计数
    QLabel * NumShow2;   //Bad技术
    QLabel *Display1;
    QLabel *Display2;

    QTextEdit * RunningInfor;
    QGroupBox *groupBox;
    QPushButton *DetectBtn;        //检测
    QPushButton *GetBack;          //生成背景
    QPushButton *AutoControlBtn;   //全自动 集成 训练 背景生成、检测和目标检测
    QPushButton *MotorTest;        //电机测试
    QPushButton *TrainSampleCap;   //训练样本采集
    QPushButton *Stop;             //停止

    QPushButton *UpdateDetector;   //更新检测器参数

    QComboBox * ComboBox;           //分类器编号选项

    QRadioButton *P;
    QRadioButton *N;
    QGroupBox *groupBox_2;
    QPushButton *TrainBtn;          //训练
    QPushButton * TestBtn;          //测试
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QStatusBar *statusBar;

    int ImageCount;
    int ImageNum;

    double BottleHeight;
    double BottleWidth;

    string FileName;
    string PointFileName;

    vector<string> ImageNames;
    vector<string> PointsStrs;


    IplImage* Src;
    IplImage* Mark;

    int ShowImage(IplImage* Image,int Num);
    int MarkImage(IplImage*img,IplImage*Mark,vector<CvPoint>& v);
    int GetLinePoints(string Str,vector<CvPoint>& Points);
    int UpdateImage();

    void ShowCount(double Height, double Width);
signals:
    void DisplayImage(QImage img,int Num);

public slots:
    void ImageShow(QImage img, int Num);
    void Next();
};

#endif // MAINWINDOW_H
