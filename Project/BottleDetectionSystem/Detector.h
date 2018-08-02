#ifndef DETECTOR_H
#define DETECTOR_H

#include <QThread>
#include <QImage>
#include <QDebug>
#include <QString>

#include<BasicOperation.h>
#include<FileOper.h>
#include<RandomForest.h>
#include<Categorizer.h>

#include"Camera.h"
#pragma once


#define  RSSTOP          (1)

#define  THREADSTART    (100)
#define  TASK           (200)
#define  SAMPLE         (300)
#define  STOP           (500)
#define  BACKGROUND     (600)
#define  OBJDETECT      (700)
#define  CONTROL        (800)
#define  TRAIN          (900)
#define  AUTO           (1800)
#define  TEST           (1000)
#define  UPDATEMODEL    (1200)

#define ON              (true)
#define OFF             (false)

#define CATENUM         (18)

#define RSDMODE_CASCADE           (0)  // 只有所有分类器都是正才正否则为负
#define RSDMODE_2IN3              (1)  // 三取二
#define RSDMODE_PARALLEL          (2)  // 只要有一个分类器是正那么就是正 否则为负
#define RSDMODE_MEAN              (3)  // 平均
#define RSDEODE_WEIMEAN           (5)  // 加权平均
#define RSDMODE_CAS_MEAN_CAS_2    (6)  // 前N-2个mean 串联 后2个的串联
#define RSDMODE_CAS_MEAN_1        (7)  // 前N-2个mean 串联 后1个


//#define RSDEBUG       (1)

class Detector: public QThread
{
    Q_OBJECT
public:
    explicit Detector(QObject *parent = 0);

    ~Detector();

    //------------配置文件名
    //------样本

    string BackgroundParamFile;         //背景检测参数文件名
    string BackgroundFileName;   //背景图像文件名

    string OnlineGoodPath;
    string OnlineBadPath;

    string PseudoPPath; //伪正路径
    string PseudoNPath;  //伪负路径

    string TestSampleInfor;        //检测器整体识别率测试样本信息

    string CategorizerConfig;      //所有分类器的配置文件名
    vector <string> CateConfigStr; //每一个字符串为一个分类器的配置文件

    long ms;
    long us;

    //分类器

    int TrainNo;   //训练哪个分类器的
    int CateNum;
    Categorizer* Cate[CATENUM];

    double Precision;          //精度 正确率:   检测正确数/总样本数
    double LossRatio;          //漏检率: 负样本并被识别为正样本数/所有负样本数
    double FalseActionRation;  // 误检率（误动率） 是正样本但是被检测为负样本数/所有正样本数

    double TotalCount;        //样本总数
    double TotalPCount;       //正样本总数
    double TotalNCount;       //负样本总数
    double PseudoPCount;      //漏检 伪正样本数：实际为负 检测为正
    double PseudoNCount;      //误检 伪负样本数：实际为正 检测为负
    double TotalFalseCount;   //识别错误数
    double TotalCorrectCount; //识别正确数

    int GoodNum;
    int BadNum;

    int DetectMode;

    //摄像机
    Camera *Cam;

    //图像
    IplImage* Background; //32位灰度
    double BackNum;
    IplImage* ProcImage;  //

    double BackThres;        //背景检测阈值
    double BinThres;         //二值化阈值
    CvRect ImageROI;         //背景检测ROI 显示颜色框的
    CvRect BackDetectROI[6]; //
    int BackDetectROINum;


    // 线程任务
    int TaskID;
    int SampleType;   //样本保存的类型 正样本或是负样本
    int Sample(int MaxNum=100);
    int CreateBackground(int MaxNum=100);
    int Control();
    bool DetectObject(); //检测是否有物体
    bool Train();        //训练
    int Test();         //分类器测试
    int AutoOperation();
    int UpdateModel();

    // 基本功能
    int ShowImage(IplImage* Image);
    int SaveImage(IplImage* Image,int OldSampleNum,string FilePath,char label,int i);
    bool DetectTask(char* Message);   //判断任务是否停止

    int Detect(IplImage* Image,int Mode=RSDMODE_CASCADE); //多分类器检测 Mode:分类器决策模式
public:
    void run();

#ifdef RSDEBUG
    int AppDebug();
#endif

    //控制
    bool SomeTaskRunning;  //正在运行
    bool TaskFinished;     //完成
    bool TaskTerm;         //终止
    bool Task;             //任务开关
    bool Thread;
    bool isTrained;

    //控制命令
    int Command;
    int CommandParam;

signals:
    void ShowMessage(QString Str);
    void Display(QImage img);
    void Clean(long Time);
    void ShowCount(int good,int bad);
public slots:
};

#endif // DETECTOR_H
