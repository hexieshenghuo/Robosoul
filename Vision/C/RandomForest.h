#include <BasicOperation.h>
#include <opencv/ml.h>
#include<FeatCreator.h>
#pragma once

/* Demo1
#include <opencv/cv.h>
#include <opencv/ml.h>
#include <opencv/cxcore.h>
int main(int argc, char *argv[])
{
    //训练数据
    float data[8]={0,0,
                   1,0,
                   0,1,
                   1,1};

    float label[4]={1,0,0,1};

    uint row=4;
    uint col=2;
    CvMat* Data=cvCreateMat(row,col,CV_32FC1);
    CvMat* Label=cvCreateMat(row,1,CV_32FC1);
    cvSetData(Data,data,sizeof(float)*col);
    cvSetData(Label,label,sizeof(float));

    for(int i=0;i<row;i++)
    {
        cout<<rsMat32F(Data,i,0)<<"   "<<rsMat32F(Data,i,1)<<endl;
    }

    //训练参数
    CvRTrees* RF= new CvRTrees;
    bool Res= RF->train( Data,CV_ROW_SAMPLE,Label);

    cout<<Res<<endl;

    float testdata[2]={2,2};
    CvMat* TestDate=cvCreateMat(1,col,CV_32FC1);

    cvSetData(TestDate,testdata,sizeof(float)*col);
    float TestR=RF->predict(TestDate);

    cout<<TestR<<endl;

    delete RF;
    cvReleaseMat(&Data);
    cvReleaseMat(&Label);
}
*/

/* Demo2 */

#define RSGOOD       (6.0)
#define RSBAD        (0.0)
#define RSTHRES      ((RSGOOD + RSBAD)/(2.0))

#define REGRESS      (1)  // 回归
#define CATEGOR      (2)  // 分类
#define TRAINTYPE    CATEGOR

class RandomForest
{
private:
    int max_depth;
    int min_sample_count;
    float regression_accuracy;
    bool use_surrogates;
    int max_categories;
    float* priors;
    bool calc_var_importance;
    int nactive_vars;
    int max_num_of_trees_in_the_forest;
    float forest_accuracy;
    int termcrit_type;

public:
    RandomForest();
    RandomForest(char*rfParamFileName, char *FeatParamFileName=0, int featmode=RSHOG);
    ~RandomForest();

    CvRTrees* rf;

    //------模型参数
    CvRTParams* RFParam;
    CvRTParams* LoadRFParam(char* FileName);
    CvMat* GetLabel(vector<int>& Label);
    int LoadParam(char* FileName);

    //------特征参数
    //以下特征参数已被忽略!
    int FeatMode;          //特征模式
    CvRect ROI;
    CvRect ImageROI;
    FeatParam featParam;


    //------训练
    int TrainType;  //分类器类型 分类还是回归
    bool Train(CvMat* Data, CvMat*Label);

    //预测
    float Threshold;
    float Predict(CvMat* Data,bool Category=true,float thres=-1.0);

    //导入保存
    int Save(char *FileName);
    int Load(char *FileName);
};

