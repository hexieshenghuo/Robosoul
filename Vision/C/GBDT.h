#ifndef GBDT_H
#define GBDT_H

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

class GBDT
{
private:
    int loss_function_type;
    /*以下为loss_function_type的说明
    // DataType: ENUM
    // Loss functions implemented in CvGBTrees.
    //
    // SQUARED_LOSS
    // problem: regression
    // loss = (x - x')^2
    //
    // ABSOLUTE_LOSS
    // problem: regression
    // loss = abs(x - x')
    //
    // HUBER_LOSS
    // problem: regression
    // loss = delta*( abs(x - x') - delta/2), if abs(x - x') > delta
    //           1/2*(x - x')^2, if abs(x - x') <= delta,
    //           where delta is the alpha-quantile of pseudo responses from
    //           the training set.
    //
    // DEVIANCE_LOSS
    // problem: classification
    //
    */
    // enum {SQUARED_LOSS=0, ABSOLUTE_LOSS=1, HUBER_LOSS=3, DEVIANCE_LOSS=4};
    int weak_count;
    float shrinkage;
    float subsample_portion;
    int max_depth;
    bool use_surrogates;
public:
    GBDT();
    GBDT(char* ParamFileName);
    ~GBDT();

    CvGBTrees* gbdt;
    CvGBTreesParams* gbdtParam;

    CvGBTreesParams* LoadParam(char* ParamFileName);
public:
    //------训练
    int TrainType;  //分类器类型 分类还是回归
    bool Update;     //训练里的一个参数，但是源码中说该参数"is not supported"
    bool Train(CvMat* Data, CvMat*Label);

    //预测
    float Threshold;
    float Predict(CvMat* Data,bool Category=true,float thres=-1.0);

    //导入保存
    int Save(char *FileName);
    int Load(char *FileName);
};

#endif // GBDT_H
