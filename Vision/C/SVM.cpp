#include "SVM.h"

SVM::SVM()
{
    Threshold=3.0;
    isAuto=0;
    svmParam=0;
}

SVM::SVM(char* ParamFileName)
{
    Threshold=3.0;
    svm=new CvSVM;
    GetClassWeight();
    svmParam=0;
    svmParam=LoadParam(ParamFileName);
}

int SVM::GetClassWeight()
{
    class_weights=0;
    return 0;
}

SVM::~SVM()
{
    if(svm)
    {
        delete svm;
        svm=0;
    }
    if(svmParam)
    {
        delete svmParam;
        svmParam=0;
    }
}

CvSVMParams* SVM::LoadParam(char* ParamFileName)
{
    //导入参数
    vector<string> Str;
    rsGetStringVector(Str,ParamFileName);

    sscanf(Str[0].c_str(),"svm_type : %d ",&svm_type);
    sscanf(Str[1].c_str(),"kernel_type : %d ",&kernel_type);
    sscanf(Str[2].c_str(),"degree : %lf ",&degree);
    sscanf(Str[3].c_str(),"gamma : %lf ",&gamma);
    sscanf(Str[4].c_str(),"coef0 : %lf ",&coef0);
    sscanf(Str[5].c_str(),"Cvalue : %lf ",&Cvalue);
    sscanf(Str[6].c_str(),"nu  : %lf ",&nu);
    sscanf(Str[7].c_str(),"p  : %lf ",&p);
    sscanf(Str[8].c_str(),"type  : %d ",&term_crit.type);
    sscanf(Str[9].c_str(),"max_iter  : %d ",&term_crit.max_iter);
    sscanf(Str[10].c_str(),"epsilon  : %lf ",&term_crit.epsilon);
    sscanf(Str[11].c_str(),"Threshold : %f ",&Threshold);
    sscanf(Str[12].c_str(),"TrainType : %d ",&TrainType);
    sscanf(Str[13].c_str(),"isAuto : %d ",&isAuto);

    term_crit.type=CV_TERMCRIT_EPS|CV_TERMCRIT_ITER;

    //创建参数结构
    if(svmParam)
    {
        delete svmParam;
        svmParam=0;
    }
    svmParam=new CvSVMParams(svm_type,kernel_type,
                             degree,gamma,coef0,
                             Cvalue,nu,p,
                             class_weights,term_crit);

    return svmParam;
}

bool SVM::Train(CvMat* Data, CvMat*Label)
{
    CvSVMParams params;
    params.svm_type    = CvSVM::C_SVC;
    params.C 		   = 0.1;
    params.kernel_type = CvSVM::LINEAR;
    params.term_crit.type   =CV_TERMCRIT_ITER;
    params.term_crit.max_iter=(int)1e7;
    params.term_crit.epsilon=1e-6;

    bool res=false;
    if(!isAuto)
    {
        res=svm->train(Data,Label,0,0,params);
    }
    else
    {
        res=svm->train_auto(Data,Label,0,0,CvSVMParams());
    }

    return res;
}

float SVM::Predict(CvMat* Data,bool Category,float thres)
{
    if(thres>0)
    {
//        Threshold=thres;
    }
    float res=svm->predict(Data);\
//cout<<"Predict Result:"<<res<<"Threshold: "<<Threshold<<endl;
    if(Category)
    {
       /* return */res=res>=Threshold?(RSGOOD):(RSBAD);
    }


    return res;
}

int SVM::Save(char *FileName)
{
    if(!svm)
    {
        return RS_ERROR;
    }
    svm->save(FileName);
    return RS_OK;
}

int SVM::Load(char *FileName)
{
    if(!svm)
    {
        return RS_ERROR;
    }
    svm->load(FileName);
    return RS_OK;
}
