#ifndef PVDETECTOR_H
#define PVDETECTOR_H

#include <QObject>
#include <QThread>
#include <QImage>
#include <QString>
#include <QFileDialog>
#include <QFileInfo>

#include<io.h>
#include <iostream>
using namespace std;

#include<rsLine.h>
//#include<imagestitch.h>


#define PV_STITCH     (1)
#define PV_DETECT     (2)
#define PV_NOTHING    (0)

class pvDetector : public QThread
{
    Q_OBJECT
public:
    explicit pvDetector(QObject *parent = 0);
    ~pvDetector();

signals:

public:
    void run();

//---属性
public:
    string FilePath;
    vector<string> VideoNames;
    int StartFlag;        //第0个视频的方向 0:由左至右 1:从右至左
    int FrameInterval;    //帧间隔
    int BeginPos;
    QByteArray StitchFileName;
    vector<IplImage*>ResImage;// 拼接与检测的结果图像

    int cmdThreadStop;    // 0:不停线程 1:停止线程
    int ThreadOn;         // 线程开启
    int RunCommand;

    string ParamFileName;
    ProParam* proParam;

    vector<HeatSpotParam> TotalHeatSpotInfor; //不同视频的热斑信息
    HeatSpotConfig heatconfig;
    CvRect HeatSpotROI;

//---方法
public:
    int GetVideoNamesFromPath(const char* Path,vector<string> & VideoNames, const char* postfix="mp4");

    int ReleaseRes();

    // 线程用函数
//    int VideoProcess(const char *VideoName, int DirectFlag, int id);
    int StitchImage();
    int VideosDetect();
    int SpotDetect(const char* FileName,int id);
    int VideoStitch(const char* FileName);

    //热斑检测
    int HeatSpotDetect(IplImage* Image, CvRect ROI, vector<HeatSpotParam>& heatspotParam, HeatSpotConfig* heatspotConfig, int id, int Pos);
    int Otsu(IplImage* img);

    int ShowImage(IplImage* Image);

signals:
    void ShowMessage(QString Str);
    void Display(QImage img);
    void ClearMessage();

public slots:

};

#endif // PVDETECTOR_H
