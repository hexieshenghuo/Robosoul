#include"RandomForest.h"

RandomForest::RandomForest()
{
    rf=new CvRTrees;
    RFParam =0;
    Threshold=RSTHRES;
    FeatMode=RSHOG;
    TrainType=TRAINTYPE;
}

CvRTParams*RandomForest::LoadRFParam(char* FileName)
{
    LoadParam(FileName);

    float prios[]={1,1};
    CvRTParams* rfparam=new CvRTParams(max_depth,
                           min_sample_count,
                           regression_accuracy,
                           use_surrogates,
                           max_categories,
                           prios,
                           calc_var_importance,
                           nactive_vars,
                           max_num_of_trees_in_the_forest,
                           forest_accuracy,
                           CV_TERMCRIT_ITER | CV_TERMCRIT_EPS  );//termcrit_type

    return rfparam;
}

RandomForest::RandomForest(char*rfParamFileName,char* FeatParamFileName,int featmode)
{
    TrainType=TRAINTYPE;
    rf=new CvRTrees;//或 rf=new CvRTrees();
    Threshold=RSTHRES;
    RFParam=LoadRFParam(rfParamFileName);

    if(!FeatParamFileName)
    {
        return;
    }

    //以下已经弃用了!
    FeatMode=featmode;
    switch (FeatMode)
    {
    case RSHOG://梯度直方图
        if(FeatParamFileName)
        {
            rsLoadHoGParam(FeatParamFileName,&featParam,&ROI,&ImageROI);
        }
        break;
    default:
        break;
    }
}

RandomForest::~RandomForest()
{
    if(rf)
    {
        delete rf;
        rf=0;
    }
    if(RFParam)
    {
        delete RFParam;
    }
}

int RandomForest::LoadParam(char* FileName)
{
    vector<string> Str;

    rsGetStringVector(Str,FileName);

    sscanf(Str[0].c_str(),"max_depth : %d ",&max_depth);
    sscanf(Str[1].c_str(),"min_sample_count : %d ",&min_sample_count);
    sscanf(Str[2].c_str(),"regression_accuracy : %f ",&regression_accuracy);
    sscanf(Str[3].c_str(),"use_surrogates : %d ",&use_surrogates);
    sscanf(Str[4].c_str(),"max_categories : %d ",&max_categories);
    int p=0;
    sscanf(Str[5].c_str(),"priors : %d ",&p);
    priors=(float*)p;
    sscanf(Str[6].c_str(),"calc_var_importance : %d ",&calc_var_importance);
    sscanf(Str[7].c_str(),"nactive_vars : %d ",&nactive_vars);
    sscanf(Str[8].c_str(),"max_num_of_trees_in_the_forest : %d ",&max_num_of_trees_in_the_forest);
    sscanf(Str[9].c_str(),"forest_accuracy : %f ",&forest_accuracy);
    sscanf(Str[10].c_str(),"termcrit_type  : %d ",&termcrit_type);

    sscanf(Str[11].c_str(),"Threshold  : %f ",&Threshold);
    sscanf(Str[12].c_str(),"TrainType  : %d ",&TrainType);

    return 0;
}

bool RandomForest::Train(CvMat* Data, CvMat*Label)
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

    bool res=rf->train(Data,CV_ROW_SAMPLE,Label,0,0,var_type,0,RFParam[0]);
    cvReleaseMat(&var_type);

    return res;
}

//训练
float RandomForest::Predict(CvMat* Data, bool Category,float thres)
{
    if(thres>0)
    {
//        Threshold=thres;
    }
    float res=rf->predict(Data);
    if(Category)
    {
       /* return */res=res>=Threshold?(RSGOOD):(RSBAD);
    }
//cout<<"Predict Result:"<<res<<"Threshold: "<<Threshold;

    return res;
}

int RandomForest::Save(char* FileName)
{
    if(!rf)
    {
        return -1;
    }
    rf->save(FileName);
    return 0;
}

int RandomForest::Load(char *FileName)
{
    if(!rf)
    {
        return -1;
    }
    rf->load(FileName);
    return 0;
}
