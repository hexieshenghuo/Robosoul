#include "Categorizer.h"


Categorizer::Categorizer(char* ConfigFileName)
{
    Precision=0;
    LossRatio=0;
    FalseActionRation=0;

    Threshold=RSTHRES;

    Data=0;
    Label=0;
    RF=0;
    Knn=0;
    Gbdt=0;
    Svm=0;

    IsNorm=1;

    vector<string> Str;
    rsGetStringVector(Str,ConfigFileName);

    sscanf(Str[0].c_str(),"catemode : %d",&CateMode);
    sscanf(Str[1].c_str(),"featmode : %d",&FeatMode);

    TrainSampleInfor=Str[4];
    TestSampleInfor=Str[5];
    ModelFileName=Str[6];
    //初始化特征参数
    switch (FeatMode)
    {
    case RSHOG://梯度直方图
        rsLoadHoGParam((char*)Str[3].c_str(),&featParam,&ROI,&ImageROI);
        break;
    case RSGRAYHIST:
        rsLoadGrayHistParam((char*)Str[3].c_str(),&featParam,&ROI,&ImageROI);
        break;
    case RSRAW:
        rsLoadRawParam((char*)Str[3].c_str(),&featParam);
        break;
    default:
        break;
    }

    //初始化分类器
    switch (CateMode)
    {
    case RSRF:
        RF=new RandomForest((char*)Str[2].c_str());
        Threshold=RF->Threshold;
        break;
    case RSKNN:
        Knn=new KNN((char*)Str[2].c_str());
        Threshold=Knn->Threshold;
        break;
    case RSGBDT:
        Gbdt=new GBDT((char*)Str[2].c_str());
        Threshold=Gbdt->Threshold;
        break;
    case RSSVM:
        Svm=new SVM((char*)Str[2].c_str());
        Threshold=Svm->Threshold;
        break;
    default:
        break;
    }
}

Categorizer::Categorizer(char*ParamFileName, char *FeatParamFileName,int catemode,int featmode)
{
    CateMode=catemode;
    FeatMode=featmode;
    Threshold=RSTHRES;

    Precision=0;
    LossRatio=0;
    FalseActionRation=0;

    Data=0;
    Label=0;

    RF=0;
    Knn=0;
    Gbdt=0;
    Svm=0;

    switch (CateMode)
    {
    case RSRF:
        RF=new RandomForest(ParamFileName,FeatParamFileName);
        Threshold=RF->Threshold;
        break;
    case RSKNN:
        Knn=new KNN(ParamFileName);
        Threshold=Knn->Threshold;
        break;
    case RSGBDT:
        Gbdt=new GBDT(ParamFileName);
        Threshold=Gbdt->Threshold;
        break;
    default:
        break;
    }
}

Categorizer::Categorizer()
{
    Data=0;
    Label=0;
    CateMode=RSRF;
    FeatMode=RSHOG;
    Precision=0;
    LossRatio=0;
    FalseActionRation=0;
    RF=0;
}

Categorizer::~Categorizer()
{
    if(RF)
    {
        delete RF;
        RF=0;
    }

    if(Knn)
    {
        delete Knn;
        Knn=0;
    }

    if(Gbdt)
    {
        delete Gbdt;
        Gbdt=0;
    }

    if(Svm)
    {
        delete Svm;
        Svm=0;
    }

    CleanSample();
}

bool Categorizer::Train(CvMat* data, CvMat*label)
{
    CvMat* d=0;
    CvMat* l=0;
    if(data){d=data;}else{d=Data;}
    if(label){l=label;}else{l=Label;}

    bool res=0;
    switch (CateMode)
    {
    case RSRF:
        res=RF->Train(d,l);
        break;
    case RSKNN:
        res=Knn->Train(d,l);
        break;
    case RSGBDT:
        res=Gbdt->Train(d,l);
        break;
    case RSSVM:
        res=Svm->Train(d,l);
        break;
    default:
        break;
    }
    return res;
}
float Categorizer::Predict(CvMat* Data,bool Category,float thres)
{
    float res=0;
    switch (CateMode)
    {
    case RSRF:
        res=RF->Predict(Data,Category,thres);
        break;
    case RSKNN:
        res=Knn->Predict(Data,Category,thres);
        break;
    case RSGBDT:
        res=Gbdt->Predict(Data,Category,thres);
        break;
    case RSSVM:
        res=Svm->Predict(Data,Category,thres);
        break;
    default:
        break;
    }
    return res;
}


int Categorizer::Save(char *FileName)
{
    int res=0;
    switch (CateMode)
    {
    case RSRF:
        if(FileName)
        {
            res=RF->Save(FileName);
        }
        else
        {
            res=RF->Save((char*)ModelFileName.c_str());
        }

        break;
    case RSKNN:
        if(FileName)
        {
            res=Knn->Save(FileName);
        }
        else
        {
            res=Knn->Save((char*)ModelFileName.c_str());
        }

        break;
    case RSGBDT:
        if(FileName)
        {
            res=Gbdt->Save(FileName);
        }
        else
        {
            res=Gbdt->Save((char*)ModelFileName.c_str());
        }

        break;
    case RSSVM:
        if(FileName)
        {
            res=Svm->Save(FileName);
        }
        else
        {
            res=Svm->Save((char*)ModelFileName.c_str());
        }
        break;

    default:
        break;
    }
    return res;
}
int Categorizer::Load(char *FileName)
{
    int res=0;
    switch (CateMode)
    {
    case RSRF:
        if(FileName)
            res=RF->Load(FileName);
        else
            res=RF->Load((char*)ModelFileName.c_str());
        break;
    case RSKNN:
        if(FileName)
            res=Knn->Load(FileName);
        else
            res=Knn->Load((char*)ModelFileName.c_str());
        break;
    case RSGBDT:
        if(FileName)
            res=Gbdt->Load(FileName);
        else
            res=Gbdt->Load((char*)ModelFileName.c_str());
        break;
    case RSSVM:
        if(FileName)
            res=Svm->Load(FileName);
        else
            res=Svm->Load((char*)ModelFileName.c_str());
        break;
    default:
        break;
    }
    return res;
}

int Categorizer::CreateSample(char* SampleInforFile)
{
    vector<string> Str;
    rsGetStringVector(Str,SampleInforFile);

    CreateSample((char*)Str[0].c_str(),(char*)Str[1].c_str());
    return 0;
}

int Categorizer::CreateSample(char* SamplePathFileName,char*SampleLabelFileName)
{
    if(Data)
    {
        cvReleaseMat(&Data);
        Data=0;
    }
    if(Label)
    {
        cvReleaseMat(&Label);
        Label=0;
    }
    vector< vector <float> > data;
    vector<float> sampleLabel;
    switch (FeatMode)
    {
    case RSHOG:
        rsCreateHoGFeatSet(data,sampleLabel,SamplePathFileName,
                          SampleLabelFileName,featParam,
                          ROI,ImageROI,true,0);
        Data=rsGetDataMat(data,featParam.FeatDim);
        Label=rsVector2Arry(sampleLabel);
        break;
    case RSGRAYHIST:
        rsCreateGrayHistFeatSet(data,sampleLabel,SamplePathFileName,
                          SampleLabelFileName,featParam,
                          ROI,ImageROI,true,0);
        Data=rsGetDataMat(data,featParam.FeatDim);
        Label=rsVector2Arry(sampleLabel);
        break;
    case RSRAW:
        Data=rsCreateRawFeatSet(&Label,SamplePathFileName,
                           SampleLabelFileName,featParam,0);
        break;
    default:

        break;
    }
    return 0;
}


int Categorizer::Evaluate(char* SampleInforFile)
{
    Load();
    if(!Data)
    {
        cout<<"Data is Empty..."<<endl;
        cout<<"Creating Sample Data......"<<endl;
        CreateSample((char*)TestSampleInfor.c_str());
    }
    if(!Data)
    {
        cout<<"Data Still is Empty..."<<endl;
        return RS_ERROR;
    }

    Precision=0;
    LossRatio=0;
    FalseActionRation=0;

    TotalCount=Data->rows; //样本总数

    TotalPCount=0;     //正样本总数
    TotalNCount=0;     //负样本总数

    PseudoPCount=0;    //漏检 伪正样本数：实际为负 检测为正
    PseudoNCount=0;    //误检 伪负样本数：实际为正 检测为负

    TotalFalseCount=0; //识别错误数
    TotalCorrectCount=0; //识别正确数

    if(SampleInforFile)
    {
        CreateSample(SampleInforFile);
    }
    else
    {
        CreateSample((char*)TestSampleInfor.c_str());
    }

    CvMat* Feat=cvCreateMat(1,Data->cols,CV_32FC1);

    rsfor(i,TotalCount)
    {
        cvGetRow(Data,Feat,i);
        float Res=Predict(Feat);

        float TruthVal=rsMat32F(Label,0,i);

        int res=(int)Res;
        int truthval=(int)TruthVal;

        //都为正
        if( ( res==truthval) &&( res== RSGOOD) )
        {
            TotalPCount+=1.0;
            TotalCorrectCount+=1.0;
        }
        //都为负
        if( ( res==truthval) && ( res== RSBAD) )
        {
            TotalNCount+=1.0;
            TotalCorrectCount+=1.0;
        }

        //误检
        if( ( res==RSBAD) &&( truthval== RSGOOD) )
        {
            TotalPCount+=1.0;
            PseudoNCount+=1.0;
        }

        //漏检
        if( ( RSGOOD==res) &&( RSBAD ==truthval) )
        {
            TotalNCount+=1.0;
            PseudoPCount+=1.0;
        }
    }

    TotalFalseCount=PseudoPCount+PseudoNCount;

    //精度
    Precision=TotalCorrectCount/TotalCount;

    //漏检率
    LossRatio=PseudoPCount/TotalNCount;

    //误检率
    FalseActionRation=PseudoNCount/TotalPCount;

cout<<"SampleCount: "<<TotalCount<<"   CorrectCount: "<<TotalCorrectCount<<"   TotalFalseCount: "<<TotalFalseCount<<endl;
cout<<"PseudoPCount: "<<PseudoPCount<<"   PseudoNCount: "<<PseudoNCount<<endl;
cout<<"TotalPCount: "<<TotalPCount<<"   TotalNCount: "<<TotalNCount<<endl;
cout<<"Precision: "<<Precision*100<<"%"<<endl;
cout<<"LossRatio: "<<LossRatio*100<<"%"<<endl;
cout<<"FalseActionRation: "<<FalseActionRation*100<<"%"<<endl;

    cvReleaseMat(&Feat);

    CleanSample();

    return 0;
}

CvMat* Categorizer::FeatExtractor(IplImage* Image)
{
    CvMat* Feat=0;
    float* f=0;
    switch (FeatMode)
    {
    case RSHOG:
        f=rsGetHoGFeat(Image,&ROI,&featParam,&ImageROI,true);
        Feat=cvCreateMat(1,featParam.FeatDim,CV_32FC1);
        cvSetData(Feat,f,sizeof(float)*featParam.FeatDim);
        break;
    case RSGRAYHIST:
        f=rsGetGrayHistFeat(Image,&ROI,&featParam,true);
        Feat=cvCreateMat(1,featParam.FeatDim,CV_32FC1);
        cvSetData(Feat,f,sizeof(float)*featParam.FeatDim);
        break;
    case RSRAW:
        Feat=rsGetRawFeat(Image,&featParam);
        break;
    default:
        break;
    }
    if(f)
    {
        delete[] f;
    }
    return Feat;
}

int Categorizer::CleanSample()
{
    if(Data)
    {
        cvReleaseMat(&Data);
        Data=0;
    }
    if(Label)
    {
        cvReleaseMat(&Label);
        Label=0;
    }
    return 0;
}
