#include "GBDT.h"

GBDT::GBDT()
{
    gbdt=0;
    Threshold=3.0;
    Update=false;
    gbdtParam=0;
}

GBDT::~GBDT()
{
    if(gbdt)
    {
        delete gbdt;
        gbdt=0;
    }
    if(gbdtParam)
    {
        delete gbdtParam;
        gbdtParam=0;
    }
}

GBDT::GBDT(char* ParamFileName)
{
    Threshold=3.0;
    Update=false;
    gbdtParam=0;

    gbdt=0;
    gbdt=new CvGBTrees;
    gbdtParam=LoadParam(ParamFileName);

}

CvGBTreesParams* GBDT::LoadParam(char* ParamFileName)
{
    //导入参数
    vector<string> Str;

    rsGetStringVector(Str,ParamFileName);
    sscanf(Str[0].c_str(),"loss_function_type : %d ",&loss_function_type);
    sscanf(Str[1].c_str(),"weak_count : %d ",&weak_count);
    sscanf(Str[2].c_str(),"shrinkage : %f ",&shrinkage);
    sscanf(Str[3].c_str(),"subsample_portion : %f ",&subsample_portion);
    sscanf(Str[4].c_str(),"max_depth : %d ",&max_depth);

    int use=0;
    sscanf(Str[5].c_str(),"use_surrogatess : %d ",&use);
    use_surrogates=use>0?true:false;

    sscanf(Str[6].c_str(),"Threshold : %f ",&Threshold);
    sscanf(Str[7].c_str(),"TrainType : %d ",&TrainType);

    //创建参数结构
    if(gbdtParam)
    {
        delete gbdtParam;
        gbdtParam=0;
    }
    gbdtParam=new CvGBTreesParams(loss_function_type,weak_count, shrinkage,
                                  subsample_portion, max_depth, use_surrogates);

    return gbdtParam;
}

bool GBDT::Train(CvMat* Data, CvMat*Label)
{
    CvMat* var_type = cvCreateMat(Data->cols + 1, 1, CV_8U );//
    cvSet( var_type, cvScalarAll(CV_VAR_NUMERICAL) );//CV_VAR_CATEGORICAL

    if(TrainType==REGRESS)//归回
    {
        rsMat8U(var_type,Data->cols, CV_VAR_CATEGORICAL);
    }
    else //分类
    {
        rsMat8U(var_type,Data->cols,0)= CV_VAR_CATEGORICAL;//2016.08.02
    }

    bool res=gbdt->train(Data,CV_ROW_SAMPLE,Label,0,0,var_type,0,gbdtParam[0]);
    cvReleaseMat(&var_type);

    return res;
}

float GBDT::Predict(CvMat* Data,bool Category,float thres)
{
    if(thres>0)
    {
//        Threshold=thres;
    }
    float res=gbdt->predict(Data);
    if(Category)
    {
       /* return */res=res>=Threshold?(RSGOOD):(RSBAD);
    }
//cout<<"Predict Result:"<<res<<"Threshold: "<<Threshold;

    return res;
}

int GBDT::Save(char *FileName)
{
    if(!gbdt)
    {
        return RS_ERROR;
    }
    gbdt->save(FileName);
    return RS_OK;
}

int GBDT::Load(char *FileName)
{
    if(!gbdt)
    {
        return RS_ERROR;
    }
    gbdt->load(FileName);
    return RS_OK;
}
