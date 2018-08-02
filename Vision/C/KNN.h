#ifndef KNN_H
#define KNN_H

#include <BasicOperation.h>
#include <FileOper.h>
#include <opencv/ml.h>

#ifndef RSGOOD
#define RSGOOD (6.0)
#endif

#ifndef RSBAD
#define RSBAD (0)
#endif

class KNN
{
private:
    //KNN参数
    int is_regression;
    int maxK;
    int updateBase;

public:
    KNN();
    KNN(char* ParamFileName);

public:
    CvKNearest* knn;

    //参数
    int LoadParam(char* FileName);

    //------训练
    bool Train(CvMat* Data, CvMat*Label);

    //预测
    float Threshold;
    int K;   //搜索最近的K个
    float Predict(CvMat* Data,bool Category=true,float thres=-1.0);

    //导入保存
    int Save(char *FileName);
    int Load(char *FileName);
};

#endif // KNN_H
