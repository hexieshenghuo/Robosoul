#ifndef CATEGORIZER_H
#define CATEGORIZER_H

#include <RandomForest.h>
#include <KNN.h>
#include <GBDT.h>
#include <SVM.h>

#define RSRF       (1)
#define RSKNN      (2)
#define RSGBDT     (3)
#define RSSVM      (5)


#define CATEMODE   RSRF

class Categorizer
{
public:
    Categorizer();

    //更新的初始化构造函数
    Categorizer(char* ConfigFileName);//ConfigFileName文件包含了: 1)分类器类型2)特征类型
                                      //3)分类器参数 4)特征参数
    //之前的初始化构造函数
    Categorizer(char*ParamFileName, char *FeatParamFileName,
                int catemode=CATEMODE,int featmode=RSHOG);
    ~Categorizer();

    //模式
    int CateMode; //分类器类别
    int FeatMode; //特征模式

    //特征&样本
    CvRect ROI;
    CvRect ImageROI;
    FeatParam featParam;
    int IsNorm;

    //训练特征数据与标签
    CvMat* Data;              //样本特征矩阵
    CvMat* Label;             //样本标签矩阵
    string TrainSampleInfor;  //训练样本信息:样本路径文件 样本标签文件
    string TestSampleInfor;   //测试样本信息:

    //分类器
    RandomForest* RF;
    KNN *Knn;
    GBDT* Gbdt;
    SVM* Svm;

    //功能
    float Threshold;

    //生成样本
    int CreateSample(char*SamplePathFileName,char*SampleLabelFileName);
    int CreateSample(char*SampleInforFile);
    int CleanSample();

    //计算特征
    CvMat* FeatExtractor(IplImage *Image);

    //评估
    double Precision; //精度 正确率:   检测正确数/总样本数
    double LossRatio; //漏检率: 负样本并被识别为负样本数/所有负样本数
    double FalseActionRation; // 误检率（误动率） 是正样本但是被检测为负样本数/所有正样本数

    double TotalCount;           //样本总数
    double TotalPCount;          //正样本总数
    double TotalNCount;          //负样本总数
    double PseudoPCount;         //漏检 伪正样本数：实际为负 检测为正
    double PseudoNCount;         //误检 伪负样本数：实际为正 检测为负
    double TotalFalseCount;      //识别错误数
    double TotalCorrectCount;    //识别正确数


    int Evaluate(char* SampleInforFile=0);

    //训练
    bool Train(CvMat *data=0, CvMat *label=0);

    //预测
    float Predict(CvMat *Data, bool Category=true, float thres=-1.0);

    //保存
    int Save(char *FileName=0);

    //导入模型
    int Load(char *FileName=0);

    string ModelFileName;
};

#endif // CATEGORIZER_H
