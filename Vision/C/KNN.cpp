#include "KNN.h"


KNN::KNN()
{
    knn=new CvKNearest;
    is_regression=true;
    maxK=15;
    updateBase=true;
    K=15;
}

KNN::KNN(char* ParamFileName)
{
    knn=new CvKNearest;
    LoadParam(ParamFileName);
}


bool KNN::Train(CvMat* Data, CvMat*Label)
{
    return knn->train(Data,Label,0,is_regression,maxK,updateBase);
}

float KNN::Predict(CvMat* Data,bool Category,float thres)
{
    if(thres>0)
    {
        Threshold=thres;
    }
    float res=knn->find_nearest(Data,K);

cout<<"Predict Result:"<<res<<" Threshold: "<<Threshold;
    if(Category)
    {
       /* return */res=res>=Threshold?(RSGOOD):(RSBAD);
    }
cout<<"Res: "<<res<<endl;
    return res;
}

int KNN::LoadParam(char* FileName)
{
    vector<string> Str;
    rsGetStringVector(Str,FileName);

    sscanf(Str[0].c_str(),"is_regression : %d ",&is_regression);
    sscanf(Str[1].c_str(),"maxK : %d ",&maxK);
    sscanf(Str[2].c_str(),"updateBase : %d ",&updateBase);
    sscanf(Str[3].c_str(),"K : %d ",&K);
    sscanf(Str[4].c_str(),"Threshold : %f",&Threshold);

    return RS_SUCCESS;
}

int KNN::Save(char* FileName)
{
    if(!knn)
    {
        return -1;
    }
//    knn->save(FileName);
    return 0;
}

int KNN::Load(char *FileName)
{
    if(!knn)
    {
        return -1;
    }
//    knn->load(FileName);
    return 0;
}
