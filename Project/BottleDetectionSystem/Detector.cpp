#include "Detector.h"
#include "MainWindow.h"

Detector::Detector(QObject *parent):QThread(parent)
{
    DetectMode=RSDMODE_CASCADE;//RSDMODE_2IN3;

    SomeTaskRunning=false;
    TaskFinished=false;     //完成
    TaskTerm=false;         //终止
    isTrained=false;

    BackDetectROINum=0;
    Command=0;

    GoodNum=0;
    BadNum=0;

    Cam=0;
    //图像
    Cam=new Camera; //该句退出异常

    Background=0;
    BackNum=0;

    ProcImage=0;

    SampleType=(int)RSGOOD;

    BackgroundFileName="F:/RoboSoul/Config/Background.jpg";

    //配置文件
    OnlineGoodPath="F:/RoboSoul/Config/Samples/onlinegood";
    OnlineBadPath="F:/RoboSoul/Config/Samples/onlinebad";

    PseudoPPath="F:/RoboSoul/Config/Samples/PseudeoP";
    PseudoNPath="F:/RoboSoul/Config/Samples/PseudeoN";

    TestSampleInfor= "F:/RoboSoul/Config/TestSampleInfor.rsc"; //检测器整体识别率测试样本信息

    //背景参数
    BackgroundParamFile="F:/RoboSoul/Config/BackgroundParam.rsc";
    BackDetectROINum=rsLoadBackgroundDetectParam((char*)BackgroundParamFile.c_str(),
                                                 &ImageROI,BackDetectROI,&BackThres,
                                                 &BinThres);

    //创建分类器
    CategorizerConfig="F:/RoboSoul/Config/Categorizer.rsc";      //分类器与特征的切入点
    rsGetStringVector(CateConfigStr,CategorizerConfig.c_str());

    //导入决策模式
    sscanf(CateConfigStr[0].c_str(),"DetectMode : %d",&DetectMode);

    CateNum=CateConfigStr.size()-1;
    TrainNo=CateNum;//0;   //训练全部
    rsfor(i,CateNum)
    {
        Cate[i] = new Categorizer((char*)CateConfigStr[i+1].c_str());
    }

    Task=OFF;
    Thread=ON;
    TaskFinished=false;

//    start();

#ifdef RSDEBUG
    AppDebug();
#endif
}

Detector::~Detector()
{
    if(Cam)
    {
        Cam->Close();
        delete Cam;
        Cam=0;
    }

    if(Background)
    {
        cvReleaseImage(&Background);
        Background=0;
    }

    rsfor(i,CateNum)
    {
        if(Cate[i])
        {
            delete Cate[i];
            Cate[i]=0;
        }
    }

    if(ProcImage)
    {
        cvReleaseImage(&ProcImage);
    }

    Task=OFF;
//    sleep(1258);
    Thread=OFF;
    for(;!isFinished();)
    {
        ;
    }
}

void Detector::run()
{
    ShowMessage("Thread Start......");
    for(;;)
    {
        //是否停止线程!
        if(!Thread)
        {
            break;
        }
        if(Task)
        {
            //任务类别
            switch(TaskID)
            {
            case SAMPLE:
                Sample(100);
                break;
            case BACKGROUND:
                CreateBackground(58);
                break;
            case OBJDETECT:
                DetectObject();
                break;
            case CONTROL:
                Control();
                break;
            case TRAIN:
                Train();
                break;
            case AUTO:
                AutoOperation();
                break;
            case TEST:
                Test();
                break;
            case UPDATEMODEL:
                UpdateModel();
                break;
            }
        }
        else
        {

        }
        msleep(1);
    }
    TaskFinished=true;
    ShowMessage("Thread End......");
}

int Detector::ShowImage(IplImage* Image)
{
    QImage img((uchar*)Image->imageData, Image->width,Image->height, QImage::Format_RGB888);
    emit Display(img);
    return 0;
}

int Detector::Sample(int MaxNum)
{
    emit ShowMessage("Sample() start......");
    string samplepath;
    char label='g';
    if(SampleType==RSGOOD)
    {
        samplepath=OnlineGoodPath;
        label='g';
    }
    else
    {
        samplepath=OnlineBadPath;
        label='b';
    }

    vector<string> FileName;
    rsGetFileNamesFromPath((char*)samplepath.c_str(),FileName,"jpg");
    int OldSampleNum=FileName.size();

    if(!Task)
    {
        return (TaskFinished=false);
    }

    if(RS_OK!=Cam->Open())
    {
        ShowMessage("Cam->Open() is Error!......");
        Task=OFF;
        return RS_ERROR;
    }

    rsfor(i,MaxNum)
    {
        //判断是否停止
        if(!Task)
        {
            Cam->Close();
            TaskTerm=true;
            emit ShowMessage("Sample() is Stopped......");
            return (TaskFinished=false);
        }

#if 0
        int index=0;
        int width,height;
        int len=0;
        CameraGetImageSize(index,&width, &height);
        CameraGetImageBufferSize(index,&len, CAMERA_IMAGE_RGB24);//
        unsigned char *buffer = new unsigned char[len];
        if(CameraQueryImage(index,buffer, &len,CAMERA_IMAGE_RGB24)==API_OK)//CAMERA_IMAGE_RGB24
        {
           IplImage* Image=cvCreateImage(cvSize(width,height),IPL_DEPTH_8U,3);
           memcpy(Image->imageData,buffer,len*sizeof(uchar));

           //保存
           ostringstream stm;
           stm<<samplepath<<"/"<<label<<(i+OldSampleNum)<<".jpg";
           string outName=stm.str();
ShowMessage(outName.c_str());
           cvSaveImage(outName.c_str(),Image);

           //显示
           QImage img(buffer, width, height, QImage::Format_RGB888);
           emit Display(img,buffer);
           cvReleaseImage(&Image);
        }
#else
        IplImage* Image=Cam->QueryImage();//注意Image 与Cam->querImage 指向同一内存，因此不需要释放
        SaveImage(Image,OldSampleNum,samplepath,label,i);
        ShowImage(Image);
#endif
    }
    Task=OFF;
    Cam->Close();
    emit ShowMessage("Sample() End......");
    return (TaskFinished=true);
}

int Detector::SaveImage(IplImage* Image,int OldSampleNum,string FilePath,char label,int i)
{
    ostringstream stm;
    stm<<FilePath<<"/"<<label<<(i+OldSampleNum)<<".jpg";
    string outName=stm.str();
//ShowMessage(outName.c_str());
    cvSaveImage(outName.c_str(),Image);
    return 0;
}

int Detector::CreateBackground(int MaxNum)
{
    BackNum=0;
    ShowMessage("CreateBackground() Start......");

    if(RS_OK!=Cam->Open())
    {
        ShowMessage("Cam->Open() is Error!......");
        Task=OFF;
        return RS_ERROR;
    }

    if(!Cam->Width||!Cam->Height)
    {
        ShowMessage("Camera is Error!......");
        Task=OFF;
        return RS_ERROR;
    }
    if(Background)
    {
        cvReleaseImage(&Background);
        Background=0;
    }

    if(!Background)
    {
        Background=cvCreateImage(cvSize(Cam->Width,Cam->Height),IPL_DEPTH_8U,3);
    }

    rsfor(i,MaxNum)
    {
        if(DetectTask((char*)"CreateBackground() Stop......"))
        {
            TaskTerm=true;
            break;
        }

        //读取图像
        IplImage* Image=Cam->QueryImage();

        //更新背景
        rsUpdateBackground(Background,Image,&BackNum,&ImageROI);

        ShowMessage("Update......");
        //保存
        cvResetImageROI(Background);
//        cvSaveImage("Background.jpg",Background);

        //显示
        ShowImage(Background);
    }
    cvSaveImage(BackgroundFileName.c_str(),Background);
    ShowMessage("Background Image is Saved......");
    ShowMessage("CreateBackground() Finished......");

    Task=OFF;
    BackNum=0;
    return 0;
}

bool Detector::DetectTask(char* Message)
{
    if(!Task)
    {
        Cam->Close();
        TaskTerm=true;
        emit ShowMessage(Message);
        TaskFinished=false;
        Task=OFF;
        return true;  //停止
    }
    return false;  //继续
}


bool Detector::DetectObject()
{
    Task=ON;
    ShowMessage("DetectObject() Start......");
    string samplepath;

    char label='g';

    if(SampleType==(int)RSGOOD)
    {
        samplepath=OnlineGoodPath;
        label='g';
    }
    else
    {
        samplepath=OnlineBadPath;
        label='b';
    }

    vector<string> FileName;
    rsGetFileNamesFromPath((char*)samplepath.c_str(),FileName,"jpg");
    int OldSampleNum=FileName.size();

    if(!Background)
    {
        Background=cvLoadImage(BackgroundFileName.c_str());
    }

    if(!Background)
    {
        CreateBackground(99);
    }

    if(RS_OK!=Cam->Open())
    {
        ShowMessage("Cam->Open() is Error!......");
        Task=OFF;
        return RS_ERROR;
    }

    rsfor(i,10000)
    {
        if(DetectTask((char*)"DetectObject() Stop......"))
        {
            break;
        }

        IplImage* Current=Cam->QueryImage();

        cvResetImageROI(Current);
        if(!ProcImage)
        {
            ProcImage=cvCreateImage(cvSize(Current->width,Current->height),IPL_DEPTH_8U,3);
        }

        cvCopyImage(Current,ProcImage);

        int res=rsBackgroundDetect(Background,ProcImage,Current,BackThres,BackDetectROI,BackDetectROINum,&BinThres);

        if(res)
        {
            //处理
            SaveImage(ProcImage,OldSampleNum,(char*)samplepath.c_str(),label,i);
            rsDrawRect(ProcImage,&ImageROI,CV_RGB(0,0,255),3);
        }
        else
        {
            rsDrawRect(ProcImage,&ImageROI,CV_RGB(0,255,0),3);
        }
        for(int k=0;k<BackDetectROINum;k++)
        {
            rsDrawRect(ProcImage,&BackDetectROI[k],CV_RGB(0,255,255),2);
        }
        ShowImage(ProcImage);
    }
    Task=OFF;
    ShowMessage("DetectObject() Finished......");
    return 0;
}


bool Detector::Train()
{
    ShowMessage("Train() Start......");

    rsfor(i,CateNum)
    {
        if(DetectTask((char*)"Train is Stopped......"))
        {
            Task=OFF;
            break;
        }
        if( TrainNo!=i && TrainNo<CateNum )//不是当前训练号也不是全部训练
        {
            continue;
        }
        if(Cate[i])
        {
            delete Cate[i];
            Cate[i]=0;
        }
        Cate[i]=new Categorizer((char*)CateConfigStr[i+1].c_str());

        ShowMessage("Generate Train Data......");
        Cate[i]->CreateSample((char*)Cate[i]->TrainSampleInfor.c_str());

        //---------训练!
        ShowMessage(QString("Categorizer %1 is Training......").arg(i));
        bool res=Cate[i]->Train();
        if(res)
        {
            ShowMessage(QString("Categorizer %1 is Success!......").arg(i));
            isTrained=true;
            Cate[i]->Save();
            ShowMessage(QString("Categorizer %1 is Saved!......").arg(i));
        }
        else
        {
            ShowMessage("Tarin False......");
            return false;
        }
        Cate[i]->CleanSample();
    }

    Task=OFF;
    return true;
}

int Detector::Control()
{
    ShowMessage("Start Control......");

    //------准备摄像机
    if(RS_OK!=Cam->Open())
    {
        ShowMessage("Cam->Open() is Error!......");
        Task=OFF;
        return RS_ERROR;
    }

    if(!Cam->Width||!Cam->Height)
    {
        ShowMessage("Camera is Error!......");
        Task=OFF;
        return RS_ERROR;
    }

    //------图像文件保存
    int GoodNum=0;
    int BadNum=0;
    vector<string> FileNameGood;
    rsGetFileNamesFromPath((char*)OnlineGoodPath.c_str(),FileNameGood,"jpg");
    int OldSampleNumGood=FileNameGood.size();

    vector<string> FileNameBad;
    rsGetFileNamesFromPath((char*)OnlineBadPath.c_str(),FileNameBad,"jpg");
    int OldSampleNumBad=FileNameBad.size();

    //------准备背景
    ShowMessage("Getting Background......");
    if(!Background)
    {
        Background=cvLoadImage(BackgroundFileName.c_str());
    }

    if(!Background)
    {
        ShowMessage("Background is Empty......");
        Task=OFF;
        return RS_ERROR;
    } 

    //---------导入模型
    ShowMessage("Getting Categorizer Model......");
    rsfor(i,CateNum)
    {
        if(Cate[i])
        {
            delete Cate[i];
            Cate[i]=0;
        }
        Cate[i]=new Categorizer((char*)CateConfigStr[i+1].c_str());
    }
    rsfor(i,CateNum)
     {
         if(!Cate[i])
         {
             ShowMessage("Need Initialize Categorizer......");
             continue;
         }
         ShowMessage(QString("Loading Categorizer %1......").arg(i));
         Cate[i]->Load();
    }

    //------------检测循环
    ShowMessage("------------------Control Start------------------");
    int DetectRes=0;//检测结果
    for(;;)
    {
        //任务停止检测
        if(DetectTask((char*)"Control() Stop......"))
        {
            Task=OFF;
            break;
        }
        //------------开始检测      
        //------捕获图像
        IplImage* Current=Cam->QueryImage();

        //------处理图像异常
        if(!Current)
        {
            ShowMessage("Cam->QueryImage() is Error......");
            if(RS_OK==Cam->ReStart())
            {
                ShowMessage("Camera Error is Resolved......");
                continue;
            }
            else
            {
                ShowMessage("Camera Error is NOT Resolved......");
                ShowMessage("Please try to Restart Detection Program......");
                Task=OFF;
                break;
            }
        }
        cvResetImageROI(Current);

        if(!ProcImage)
        {
            ProcImage=cvCreateImage(cvSize(Current->width,Current->height),IPL_DEPTH_8U,3);
        }
        cvCopyImage(Current,ProcImage);

        //检测是否有瓶子
        int IsObject=rsBackgroundDetect(Background,ProcImage,Current,
                                   BackThres,BackDetectROI,BackDetectROINum,
                                   &BinThres);

        if(IsObject)//---------检测到有瓶子
        {
            //检测
            DetectRes=Detect(ProcImage,DetectMode);
//            DetectRes=RSGOOD;

            //恢复图像ROI
            cvResetImageROI(ProcImage);

            //------检测到问题瓶子
            if(DetectRes==RSBAD)
            {
                //处理
                //发送命令踢瓶
                emit Clean(ms);
                SaveImage(ProcImage,OldSampleNumBad,OnlineBadPath,'n',BadNum++);
                ShowMessage("Found a Bad Bottle------------");
                rsDrawRect(ProcImage,&ImageROI,CV_RGB(255,0,0),3);
            }
            else
            {
                //好瓶子
                SaveImage(ProcImage,OldSampleNumGood,OnlineGoodPath,'p',GoodNum++);
                ShowMessage(QString("This is a Good One************"));
                rsDrawRect(ProcImage,&ImageROI,CV_RGB(0,0,255),3);
            }
        }
        //---------没瓶子
        else
        {
            rsDrawRect(ProcImage,&ImageROI,CV_RGB(0,255,0),3);
        }

        for(int k=0;k<BackDetectROINum;k++)
        {
            rsDrawRect(ProcImage,&BackDetectROI[k],CV_RGB(0,255,255),2);
        }

        emit ShowImage(ProcImage);


        emit ShowCount(GoodNum,BadNum);
cout<<"Back......"<<endl;
    }
    Task=OFF;
    return 0;
}

int Detector::AutoOperation()
{
    //训练
    //背景生成
    //检测
    return 0;
}

int Detector::Test()
{
    //单独测试某个分类器
    ShowMessage("Test Begin......");

    //图像文件保存
    int PseudoP=0;
    int PseudoN=0;
    vector<string> FileNameGood;
    rsGetFileNamesFromPath((char*)PseudoPPath.c_str(),FileNameGood,"jpg");
    int OldSampleNumP=FileNameGood.size();

    vector<string> FileNameBad;
    rsGetFileNamesFromPath((char*)PseudoNPath.c_str(),FileNameBad,"jpg");
    int OldSampleNumN=FileNameBad.size();

    if(TrainNo<CateNum)
    {
        if(!Cate[TrainNo])
        {
            ShowMessage("Categorizer is Error to Not Test......");
        }

        if(RS_ERROR==Cate[TrainNo]->Evaluate())
        {
            Task=OFF;
            return -1;
        }
    }
    else //整体分类器测试
    {
        rsfor(i,CateNum)
        {
            ShowMessage(QString("Load Categorizer %1").arg(i));
            Cate[i]->Load();
        }

        Precision=0;
        LossRatio=0;
        FalseActionRation=0;

        TotalCount=0; //样本总数

        TotalPCount=0;     //正样本总数
        TotalNCount=0;     //负样本总数

        PseudoPCount=0;    //漏检 伪正样本数：实际为负 检测为正
        PseudoNCount=0;    //误检 伪负样本数：实际为正 检测为负

        TotalFalseCount=0; //识别错误数
        TotalCorrectCount=0; //识别正确数


        vector<string>  TestInfor;
        vector <string> FilePath; //样本路径字符串
        vector <string> LabelString;    //样本标签

        rsGetStringVector(TestInfor,TestSampleInfor.c_str()); //样本good_1或bad_1

        rsGetStringVector(FilePath,TestInfor[0].c_str());

        rsGetStringVector(LabelString,TestInfor[1].c_str());

        int FilePathNum=FilePath.size();

        int samplecount=0;
        rsfor(i,FilePathNum)
        {
            vector<string> FileNames;
            rsGetFileNamesFromPath((char*)FilePath[i].c_str(),FileNames,"jpg");
            int FileNum=FileNames.size();
            int truthval=0;
            sscanf(LabelString[i].c_str(),"%d ",&truthval);

            rsfor(j,FileNum)
            {
                //读图像
                IplImage* Image=cvLoadImage(FileNames[j].c_str(),CV_LOAD_IMAGE_GRAYSCALE);
//rsStartTime(T);
                int res=Detect(Image,DetectMode);
//T=rsGetTime(T);
//ShowMessage(QString("Time is %0 ms").arg(T));

                if(samplecount++%500==0)
                {
                    ShowMessage(QString("Testing......"));
                }

                //---------统计
                TotalCount+=1.0;
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
                if( ( res==RSBAD)&&( truthval== RSGOOD) )
                {
                    TotalPCount+=1.0;
                    PseudoNCount+=1.0;
                    SaveImage(Image,OldSampleNumN,PseudoNPath,'N',PseudoN++);

                    ShowMessage(FileNames[j].c_str());
                    ShowMessage("------------------\n\n\n");
                }

                //漏检
                if( ( res==RSGOOD) &&( truthval==RSBAD) )
                {
                    TotalNCount+=1.0;
                    PseudoPCount+=1.0;
                    SaveImage(Image,OldSampleNumP,PseudoPPath,'P',PseudoP++);
                    ShowMessage(FileNames[j].c_str());
                    ShowMessage("------------------\n\n\n");
                }
                cvReleaseImage(&Image);
                Image=0;
            }
        }
        TotalFalseCount=PseudoPCount+PseudoNCount;
        //精度
        Precision=TotalCorrectCount/TotalCount;
        //漏检率
        LossRatio=PseudoPCount/TotalNCount;
        //误检率
        FalseActionRation=PseudoNCount/TotalPCount;

        ShowMessage(QString("SampleCount: %1   CorrectCount: %2   TotalFalseCount: %3").arg(TotalCount).arg(TotalCorrectCount).arg(TotalFalseCount));
        ShowMessage(QString("PseudoPCount: %1   PseudoNCount: %2").arg(PseudoPCount).arg(PseudoNCount));
        ShowMessage(QString("TotalPCount: %1   TotalNCount: %2").arg(TotalPCount).arg(TotalNCount));
        ShowMessage(QString("Precision: %1%").arg(Precision*100));
        ShowMessage(QString("LossRatio: %1%").arg(LossRatio*100));
        ShowMessage(QString("FalseActionRation: %1%").arg(FalseActionRation*100));
    }
    Task=OFF;
    ShowMessage("Test End......");
    return 0;
}

int Detector::Detect(IplImage* Image, int Mode)
{
    int Result=RSGOOD;

    //平均
    float ResSum=0;

    //加权平均
    float Weight[CATENUM]={0};
    float Res[CATENUM]={0};
    float WeightSum=0;
    float thres=RSTHRES;

    switch (Mode)
    {
    case RSDMODE_CASCADE:
        rsfor(i,CateNum)
        {
            CvMat* Feat=Cate[i]->FeatExtractor(Image);
            int res =(int)(Cate[i]->Predict(Feat));
            cvReleaseMat(&Feat);
            // 某一个分类器检测出错误停止检测退出
            if(RSBAD==res)
            {
                Result=RSBAD;
                break;
            }
        }
        break;
    case RSDMODE_2IN3: //三取二
        if(CateNum!=3)
        {
            Result=Detect(Image,RSDMODE_CASCADE);
        }
        else //三取二
        {
            int L0=0;
            int L1=0;
            int L2=0;
            int Res[3]={0,0,0};
            rsfor(i,CateNum)
            {
                CvMat* Feat=Cate[i]->FeatExtractor(Image);
                Res[i] =(int)(Cate[i]->Predict(Feat));
                cvReleaseMat(&Feat);
            }

            L0=(Res[0]==RSBAD || Res[1]==RSBAD )?(RSBAD):(RSGOOD);
            L1=(Res[0]==RSBAD || Res[2]==RSBAD )?(RSBAD):(RSGOOD);
            L2=(Res[2]==RSBAD || Res[1]==RSBAD )?(RSBAD):(RSGOOD);

            Result=(L1==RSGOOD || L2==RSGOOD || L0==RSGOOD )?(RSGOOD):(RSBAD);
        }
        break;
    case RSDMODE_PARALLEL:
        Result=RSBAD;
        rsfor(i,CateNum)
        {
            CvMat* Feat=Cate[i]->FeatExtractor(Image);
            int res =(int)(Cate[i]->Predict(Feat));
            cvReleaseMat(&Feat);
            // 某一个分类器检测出错误停止检测退出
            if(RSGOOD==res)
            {
                Result=RSGOOD;
                break;
            }
        }
        break;
    case RSDMODE_MEAN: //平均
        ResSum=0;
        rsfor(i,CateNum)
        {
            CvMat* Feat=Cate[i]->FeatExtractor(Image);
            float res =Cate[i]->Predict(Feat,false);
            cvReleaseMat(&Feat);
            ResSum+=res;
        }
        Result=ResSum/CateNum;
        Result=Result<thres?(RSBAD):(RSGOOD);
        break;
    case RSDEODE_WEIMEAN: //加权平均
        //计算结果与权值
        rsfor(i,CateNum)
        {
            CvMat* Feat=Cate[i]->FeatExtractor(Image);
            Res[i] =Cate[i]->Predict(Feat,false);
            cvReleaseMat(&Feat);
            Weight[i]=abs(Res[i]-thres);
            WeightSum+=Weight[i];
        }

        //加权计算
        Result=0;
        rsfor(i,CateNum)
        {
            Result+=Weight[i]/WeightSum*Res[i];
        }
        Result=Result<thres?(RSBAD):(RSGOOD);
        break;

    case RSDMODE_CAS_MEAN_CAS_2:
        ResSum=0;
        if(CateNum<4)
        {
            Result=Detect(Image,RSDMODE_CASCADE);
        }
        else
        {
            //计算平均

            rsfor(i,CateNum-2)
            {
                CvMat* Feat=Cate[i]->FeatExtractor(Image);
                float res =Cate[i]->Predict(Feat,false);
                cvReleaseMat(&Feat);
                ResSum+=res;
            }
            ResSum=ResSum/(CateNum-2);
            int Res1=ResSum<RSTHRES?(RSBAD):(RSGOOD);

            //计算局部的串联
            int res[2]={0};
            int Pos=CateNum-2;
            for(int i=CateNum-2;i<CateNum;i++)
            {
                CvMat* Feat=Cate[i]->FeatExtractor(Image);
                res[i-Pos] =Cate[i]->Predict(Feat);
                cvReleaseMat(&Feat);
            }
            int Res2=(res[0]==RSBAD || res[1]==RSBAD)?(RSBAD):(RSGOOD);
            //串联
            Result=(Res1==RSBAD || Res2==RSBAD)?(RSBAD):(RSGOOD);
        }
        break;
    case RSDMODE_CAS_MEAN_1:
        ResSum=0;
        if(CateNum<3)
        {
            Result=Detect(Image,RSDMODE_CASCADE);
        }
        else
        {
            //计算平均

            rsfor(i,CateNum-1)
            {
                CvMat* Feat=Cate[i]->FeatExtractor(Image);
                float res =Cate[i]->Predict(Feat,false);
                cvReleaseMat(&Feat);
                ResSum+=res;
            }
            ResSum=ResSum/(CateNum-1);
            int Res1=ResSum<RSTHRES?(RSBAD):(RSGOOD);

            //计算局部的串联
            int res[1]={0};
            int Pos=CateNum-1;
            for(int i=CateNum-1;i<CateNum;i++)
            {
                CvMat* Feat=Cate[i]->FeatExtractor(Image);
                res[i-Pos] =Cate[i]->Predict(Feat);
                cvReleaseMat(&Feat);
            }
            int Res2=res[0];
            //串联
            Result=(Res1==RSBAD || Res2==RSBAD)?(RSBAD):(RSGOOD);
        }
        break;
    }

    return Result;
}

int Detector::UpdateModel()
{
//    ShowMessage("UpdateModel Start......");
//    if(Cate[0])
//    {
//        delete Cate[0];
//        Cate[0]=0;
//    }
//    Cate[0]=new Categorizer((char*)CateConfigStr[0].c_str());

//    ShowMessage("Model Loading......");
//    Cate[0]->Load();

//    ShowMessage("Create Sample......");
//    Cate[0]->CreateSample((char*)Cate[0]->TrainSampleInfor.c_str());


//    ShowMessage("Model Training......");
//    Cate[0]->Train();

//    ShowMessage("UpdateModel End......");
    return 0;
}

#ifdef RSDEBUG
int Detector::AppDebug()
{
    cout<<"AppDebug()"<<endl;
    // //n106"F:/RoboSoul/Config/Samples/bad/p10277.jpg";
    //F:/RoboSoul/Config/Samples/Sample_07_26/Samples6/bad/p4575.jpg";

    //
    //"F:/RoboSoul/Config/Samples/testbad/g807 (2).jpg";
    const char* fileName="F:/1.jpg";
    IplImage* Image=cvLoadImage(fileName);

    rsfor(i,Cate[0]->featParam.HogCellType)
    {
        rsDrawRect(Image,&Cate[0]->featParam.HoGCell[i],CV_RGB(0,255,0),1);
    }

    cvNamedWindow("Show");
    cvShowImage("Show",Image);
    cvWaitKey(0);

    cvReleaseImage(&Image);
    return 0;
}
#endif
