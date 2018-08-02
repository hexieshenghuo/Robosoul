#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

//#include <QtCore/QVariant>
//#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QGroupBox>
//#include <QtWidgets/QHeaderView>
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

#include "Detector.h"
#include "Motor.h"

#pragma once

#define SHOWWID       (320)
#define SHOWHEI       (240)

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();
public:
    //---------界面控件
    QWidget *centralWidget;
    QLabel *label;
    QLabel * NumShow1;   //Good计数
    QLabel * NumShow2;   //Bad技术
    QLabel *Display;
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

public:
    //---------文件名

public:
    //---------主要功能
    Detector* detector;
    Motor* motor;
    string ComNameFileName;

signals:
    void ShowMessage(QString Str);
    void SendCommand(int Command,void* CommandParam);

public slots:
    void UpdateMessage(QString Str); //消息显示槽函数
    void MotorAction();              //电机动作槽函数
    void Auto();
    void TaskStop();
    void CreateBack();
    void ImageShow(QImage img);

    void TypeChanged();
    void TrainSample();              //获取训练样本，利用背景检测把好瓶和坏瓶的图像采集出来

    void Train();
    void Detect();

    void Test();   //分类器测试

    void ComboBoxProc(int Index);

    void ShowCount(int good,int bad);
    void updateDetector();  //更新分类器
};

#endif // MAINWINDOW_H
