#include"SamplePathWidget.h"
#include <QApplication>
#include <iostream>
using namespace std;
//#include"RandomForest.h"
#include "TrainWidget.h"
//#include <Categorizer.h>

#include <cv.h>       // opencv general include file
#include <ml.h>         // opencv machine learning include file

using namespace cv;

#define demo  (2)

#if (demo==0)
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    //训练数据
    float data[]={0,0, // 1
                  1,0, // 1
                  0,1, // 1
                  1,1, // 1
                  2,-1, // 0
                 -1,2,  // 0
                  2,0, // 1
                 -1,-1, // 0
                  0,9, // 1
                 -1,10}; // 0

    float label[]={1,1,1,1,0,
                   0,1,0,1,0};

    uint row=10;
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

    Mat MatData = Mat(Data,true);
    Mat MatLabel=Mat(Label,true);

    CvRTrees* RF= new CvRTrees;

//    bool Res= RF->train( Data,CV_ROW_SAMPLE,Label,0,0,0,0,CvRTParams( 10, 2, 0,false,16, 0, true, 0, 100, 0,CV_TERMCRIT_ITER) );


#if 0
    Mat var_type = Mat(col+1, 1, CV_8U );
    var_type.setTo(Scalar(CV_VAR_NUMERICAL) ); // all inputs are numerical

    var_type.at<uchar>(col, 0) = CV_VAR_CATEGORICAL;
#else
//    CvMat* var_type = cvCreateMat(Data->cols + 1, 1, CV_8U );//
//    uchar* v=new uchar[Data->cols+1];
//    memset(v,CV_VAR_NUMERICAL,sizeof(uchar)*(Data->cols+1));
//    cvSetData(var_type,v,sizeof(uchar)*(Data->cols+1));
//    rsMat8U(var_type,Data->cols, CV_VAR_CATEGORICAL);

    CvMat* var_type = cvCreateMat(Data->cols + 1, 1, CV_8U );//
    cvSet( var_type, cvScalarAll(CV_VAR_NUMERICAL) );
//    cvSetReal1D(var_type,Data->cols,CV_VAR_CATEGORICAL);
    rsMat8U(var_type,Data->cols, CV_VAR_CATEGORICAL);
#endif
    float priors[] = {1,1};
    CvRTParams params = CvRTParams(10, // max depth
                                          2, // min sample count
                                          0, // regression accuracy: N/A here
                                         false, // compute surrogate split, no missing data
                                         18, // max number of categories (use sub-optimal algorithm for larger numbers)
                                           priors, // the array of priors
                                          false,  // calculate variable importance
                                          2,       // number of variables randomly selected at node and used to find the best split(s).
                                          100,  // max number of trees in the forest
                                          0.01f,               // forrest accuracy
                                           CV_TERMCRIT_ITER |   CV_TERMCRIT_EPS // termination cirteria
                                         );


//    bool Res=RF->train(MatData,CV_ROW_SAMPLE,MatLabel,Mat(), Mat(), var_type,Mat(),params);
     bool Res=RF->train(Data,CV_ROW_SAMPLE,Label,0,0, var_type,0,params);
    cout<<Res<<endl;

    float testdata[2]={20,3};
    CvMat* TestDate=cvCreateMat(1,col,CV_32FC1);



    cvSetData(TestDate,testdata,sizeof(float)*col);
    Mat MatTestData=Mat(TestDate,true);
    float TestR=cvRound(RF->predict(TestDate));

    cout<<TestR<<endl;

    delete RF;
    cvReleaseMat(&Data);
    cvReleaseMat(&Label);


//    TrainWidget W;
//    W.show();


    return a.exec();
}

#elif (demo==1)
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    TrainWidget W;
    W.show();

    return a.exec();
}
#elif (demo==2)



CvMat*  GetHOGFeatSet(CvMat** Label,char* SamplePath, char* LabelFileName,
                  FeatParam featparam, CvRect ROI,CvRect ImageROI, bool Norm,void* ExtParam)
{
     //---------获得PathLabel
     vector<int> PathLabel;            //每个文件夹的样本标签
     PathLabel.clear();
     vector<string>LabelString;
     rsGetStringVector(LabelString,LabelFileName);
     for(int i=0;i<LabelString.size();i++)
     {
         int label;
         sscanf(LabelString[i].c_str(),"%d ",&label);
         PathLabel.push_back(label);
         cout<<"Label"<<i<<":"<<PathLabel[i]<<endl;
     }
     //---------获得特征数据和样本标签
     CvMat* Data=0;
     vector<string> SampleFilePath;//样本文件夹字符串

     rsGetStringVector(SampleFilePath,SamplePath);
     int PathNum=SampleFilePath.size();

     vector<float> SampleLabel;//样本标签
     SampleLabel.clear();

     for(int i=0;i<PathNum;i++)
     {
         vector<string> FileNames;

         rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
         int SampleNum=FileNames.size();

         float* Features =new float[SampleNum*featparam.FeatDim];

         for(int j=0;j<SampleNum;j++)
         {
             IplImage* Image=cvLoadImage(FileNames[j].c_str());
             float* f= rsGetHoGFeat(Image,&ROI,&featparam,&ImageROI);
             if(Norm)
             {
                 rsNormalizeVector(f,featparam.FeatDim);
             }

             memcpy(Features+j*featparam.FeatDim,f,sizeof(float)*featparam.FeatDim);
             SampleLabel.push_back((float)PathLabel[i]);

             delete[] f;
             f=0;
             cvReleaseImage(&Image);
             Image=0;
         }

         CvMat* data=cvCreateMat(SampleNum,featparam.FeatDim,CV_32FC1);
         cvSetData(data,Features,sizeof(float)*featparam.FeatDim);

         Data=rsComposeMat(Data,data,&Data);

         cvReleaseMat(&data);

         FileNames.clear();
         delete [] Features;
     }

     //获得CvMat*形式Label
     cout<<"Data->rows:"<<Data->rows<<endl;
     Label[0]=cvCreateMat(Data->rows,1,CV_32FC1);

     for(int i=0;Data->rows;i++)
     {
         rsMat32F(Label[0],i,0)=SampleLabel[i];
     }
     for(int i=0;i<Data->rows;i++)
     {
         for(int j=0;j<Data->cols;j++)
         {
             cout<<rsMat32F(Data,i,j)<<" ";
         }
         cout<<endl;
     }

     return Data;
}


#if 0
int getSet(vector<vector<float>> &data,vector<float>& SampleLabel,char* SamplePath, char* LabelFileName,
                  FeatParam featparam, CvRect ROI,CvRect ImageROI, bool Norm,void* ExtParam)
{

    //---------获得PathLabel
    vector<int> PathLabel;            //每个文件夹的样本标签
    PathLabel.clear();
    vector<string>LabelString;
    rsGetStringVector(LabelString,LabelFileName);
    for(int i=0;i<LabelString.size();i++)
    {
        int label;
        sscanf(LabelString[i].c_str(),"%d ",&label);
        PathLabel.push_back(label);
        cout<<"Label"<<i<<":"<<PathLabel[i]<<endl;
    }
    //---------获得特征数据和样本标签
    vector<string> SampleFilePath;//样本文件夹字符串

    rsGetStringVector(SampleFilePath,SamplePath);
    int PathNum=SampleFilePath.size();

    for(int i=0;i<PathNum;i++)
    {
        vector<string> FileNames;

        rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
        int SampleNum=FileNames.size();
        for(int j=0;j<SampleNum;j++)
        {
            IplImage* Image=cvLoadImage(FileNames[j].c_str());
            float* f= rsGetHoGFeat(Image,&ROI,&featparam,&ImageROI);
            if(Norm)
            {
                rsNormalizeVector(f,featparam.FeatDim);
            }

            vector<float> v;
            Arry2Vector(f, v,featparam.FeatDim);

            data.push_back(v);

            SampleLabel.push_back((float)PathLabel[i]);

            delete[] f;
            f=0;
            cvReleaseImage(&Image);
            Image=0;
        }

        FileNames.clear();
    }
    return 0;
}
#endif

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

#if 0 //准备数据 最开始好的没问题的!
/*
    char* FilePath=(char*)"G:/RoboSoul/TestData/BottleSamples/sample";
    CvMat* Data=0;

    vector<string> FileNames;
    rsGetFileNamesFromPath(FilePath,FileNames,"jpg");

    int SampleNum=FileNames.size();

    cout<<"SampleNum:"<<SampleNum<<endl;

    for(int i=0;i<SampleNum;i++)
    {
        cout<<FileNames[i].c_str()<<endl;
    }

    CvRect ROI=cvRect(0,0,140,200);
    CvRect ImageROI=cvRect(0,0,140,200);

    FeatParam featParam;
    char* hogfile=(char*)"G:/RoboSoul/Config/HoGFeatParam.rsc";
    rsLoadHoGParam(hogfile,&featParam,&ROI,&ImageROI);

    cout<<"FeatParam.HoGCell: "<<endl;
    for(int i=0;i<featParam.HogCellType;i++)
    {
        cout<<featParam.HoGCell[i].x<<" "
            <<featParam.HoGCell[i].y<<" "
            <<featParam.HoGCell[i].width<<" "
            <<featParam.HoGCell[i].height<<endl;
    }

    for(int i=0;i<SampleNum;i++)
    {
        IplImage* Image=cvLoadImage(FileNames[i].c_str());
        float* f= rsGetHoGFeat(Image,&ROI,&featParam,&ImageROI);

        rsNormalizeVector(f,featParam.FeatDim);

        for(int j=0;j<featParam.FeatDim;j++)
        {
            cout<<(double)f[j]<<" ";
        }
        cout<<endl;

        CvMat* Feat=cvCreateMat(1,featParam.FeatDim,CV_32FC1);

        cvSetData(Feat,f,sizeof(float)*featParam.FeatDim);

        Data=rsComposeMat(Data,Feat,&Data);

        for(int j=0;j<featParam.FeatDim;j++)
        {
            cout<<(double)rsMat32F(Data,i,j)<<" ";
        }
        cout<<endl;

        delete[] f;
        cvReleaseMat(&Feat);
        cvReleaseImage(&Image);
        Image=0;
    }

    float label[]={0,0,0,0,0,0,0,0,0,0,
                   1,1,1,1,1,1,1,1,1,1};
    CvMat* Label=cvCreateMat(SampleNum,1,CV_32FC1);
    cvSetData(Label,label,sizeof(float));
    */
#else

//    RandomForest* RF=new RandomForest((char*)"../../Config/RFParam.rsc",
//                                      (char*)"G:/RoboSoul/Config/HoGFeatParam.rsc");

    Categorizer* Cate=new Categorizer((char*)"../../Config/RFParam.rsc",
                                      (char*)"F:/RoboSoul/Config/HoGFeatParam.rsc");

    char* SamplePath=(char*)"../../Config/TrainSamplePath.rsc";
    char* LabelFileName=(char*)"../../Config/PathLabel.rsc";


    vector< vector <float> > data;
    vector<float> SampleLabel;

    rsCreateHoGFeatSet(data,SampleLabel,SamplePath,LabelFileName,Cate->RF->featParam,
                          Cate->RF->ROI,Cate->RF->ImageROI,true,0);

    CvMat* Data=rsGetDataMat(data,Cate->RF->featParam.FeatDim);
    CvMat* Label=rsVector2Arry(SampleLabel);

#if 1
    for(int i=0;i<Data->rows;i++)
    {
        for(int j=0;j<Data->cols;j++)
        {
            cout<<rsMat32F(Data,i,j)<<" ";
        }
        cout<<endl;
    }
#endif

#endif

    //训练


//    CvMat* var_type = cvCreateMat(Data->cols + 1, 1, CV_8U );//
//    cvSet( var_type, cvScalarAll(CV_VAR_NUMERICAL) );
//    rsMat8U(var_type,Data->cols, CV_VAR_CATEGORICAL);

//    float priors[] = {1,1};
//    CvRTParams params = CvRTParams(10, // max depth
//                                          2, // min sample count
//                                          0, // regression accuracy: N/A here
//                                          false, // compute surrogate split, no missing data
//                                          18, // max number of categories (use sub-optimal algorithm for larger numbers)
//                                          priors, // the array of priors
//                                          false,  // calculate variable importance
//                                          6,       // number of variables randomly selected at node and used to find the best split(s).
//                                          100,  // max number of trees in the forest
//                                          0.01f,               // forrest accuracy
//                                          CV_TERMCRIT_ITER |   CV_TERMCRIT_EPS // termination cirteria
//                                         );



//    bool res=RF->train(Data,CV_ROW_SAMPLE,Label,0,0,var_type,0,params);

    bool res=Cate->Train(Data,Label);

    Cate->Save((char*)"F:/RoboSoul/Config/CateModel.xml");
    cout<<"res:"<<res<<endl;

    //预测
    cout<<"-----------------"<<endl;
    char* testFilePath=(char*)"F:/RoboSoul/Config/Samples/testgood";
    vector<string> testFileNames;
    rsGetFileNamesFromPath(testFilePath,testFileNames,"jpg");

    int testSampleNum=testFileNames.size();

//  char* TestFileNames=(char*)"F:/RoboSoul/TestData/BottleSamples/test_top_good/g1.jpg";

    for(int i=0;i<testSampleNum;i++)
    {
        IplImage* TestImage=cvLoadImage(testFileNames[i].c_str());
        rsStartTime(T);
        float* TestF=rsGetHoGFeat(TestImage,&Cate->RF->ROI,&Cate->RF->featParam,&Cate->RF->ImageROI);

        CvMat* TestFeat=cvCreateMat(1,Cate->RF->featParam.FeatDim,CV_32FC1);
        cvSetData(TestFeat,TestF,sizeof(float)*Cate->RF->featParam.FeatDim);

        float TestRes=Cate->Predict(TestFeat,true);//cvRound();//;
        cout<<Cate->Threshold<<endl;

        T=rsGetTime(T);
        cout<<"Time:"<<T<<"ms"<<endl;
        cout<<"PredictRes:"<<TestRes<<endl;

        delete[] TestF;
        cvReleaseMat(&TestFeat);
        cvReleaseImage(&TestImage);
    }

    cvReleaseMat(&Data);


    delete Cate;

    return a.exec();
}
#elif (demo==3)

float* fun()
{
    float* F=new float[3];
    F[0]=1;
    F[1]=2;
    F[2]=3;
    return F;
}

float* Gen()
{
    return fun();
}

float* g()
{
    return Gen();
}

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
#if 0
    CvRect ROI=cvRect(0,0,30,30);
    IplImage* Image1=cvCreateImage(cvSize(60,60),IPL_DEPTH_8U,3);
    IplImage* Image2=cvCreateImage(cvSize(60,60),IPL_DEPTH_8U,3);

    cvZero(Image1);
    cvZero(Image2);

    rsImage8U3(Image1,10,10,1)=3.0;
    rsImage8U3(Image2,20,10,2)=3.0;

    cvSetImageROI(Image1,ROI);
    cvSetImageROI(Image2,ROI);


    cvAbsDiff(Image1,Image2,Image1);

    CvScalar Res=cvSum(Image1);

    cout<<Res.val[0]<<" "<<Res.val[1]<<" "<<Res.val[2]<<" "<<Res.val[3]<<" "<<endl;
#endif

    CvRect ROI;
    double Threshold=0;
    rsLoadBackgroundDetectParam((char*)"G:/RoboSoul/Config/BackgroundParam.rsc",& ROI,&Threshold);
    cout<<ROI.x<<" "<<ROI.y<<" "<<ROI.width<<" "<<ROI.height<<" "<<endl;
    cout<<"Threshold:"<<Threshold<<endl;


    return a.exec();
}
#endif
