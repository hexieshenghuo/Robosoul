#ifndef SVM_H
#define SVM_H

#include <BasicOperation.h>
#include <opencv/ml.h>
#include<FeatCreator.h>
#pragma once

#ifndef RSGOOD
#define RSGOOD       (6.0)
#endif

#ifndef RSBAD
#define RSBAD        (0.0)
#endif

#ifndef RSTHRES
#define RSTHRES      (( RSGOOD + RSBAD)/(2.0))
#endif

#ifndef REGRESS
#define REGRESS     (1)  // 回归
#endif

#ifndef CATEGOR
#define CATEGOR     (2)  // 分类
#endif

#ifndef TRAINTYPE
#define TRAINTYPE   CATEGOR
#endif

class SVM
{
private:

    //SVM参数
    int svm_type; // enum { C_SVC=100, NU_SVC=101, ONE_CLASS=102, EPS_SVR=103, NU_SVR=104 };
    int kernel_type;// SVM kernel type enum { LINEAR=0, POLY=1, RBF=2, SIGMOID=3 };
    double degree;
    double gamma;
    double coef0;
    double Cvalue;
    double nu;
    double p;
    CvMat* class_weights;
    CvTermCriteria term_crit;
public:
    SVM();
    SVM(char* ParamFileName);
    ~SVM();
public:

    CvSVM* svm;
    CvSVMParams* svmParam;
    CvSVMParams* LoadParam(char* ParamFileName);
    int GetClassWeight();
public:
    //------训练
    int TrainType;  //分类器类型 分类还是回归
    int isAuto;     //训练是否调用train_auto()函数
    bool Train(CvMat* Data, CvMat*Label);

    //预测
    float Threshold;
    float Predict(CvMat* Data,bool Category=true,float thres=-1.0);

    //导入保存
    int Save(char *FileName);
    int Load(char *FileName);
};

#endif // SVM_H
