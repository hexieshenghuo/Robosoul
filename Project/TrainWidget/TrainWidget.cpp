#include "TrainWidget.h"

TrainWidget::TrainWidget(QWidget *parent) : QWidget(parent)
{
    this->resize(725, 356);
    textEdit = new QTextEdit(this);
    textEdit->setObjectName(QStringLiteral("textEdit"));
    textEdit->setGeometry(QRect(450, 10, 261, 271));
    textEdit->setMaximumSize(QSize(16777215, 16777215));

    LoadBtn = new QPushButton(this);
    LoadBtn ->setObjectName(QStringLiteral("LoadBtn"));
    LoadBtn ->setGeometry(QRect(450, 290, 51, 23));
    LoadBtn ->setText("加载");

    SaveFileBtn = new QPushButton(this);
    SaveFileBtn->setObjectName(QStringLiteral("SaveFileBtn"));
    SaveFileBtn->setGeometry(QRect(510, 290, 51, 23));
    SaveFileBtn->setText("保存");

    TrainBtn = new QPushButton(this);
    TrainBtn->setObjectName(QStringLiteral("TrainBtn"));
    TrainBtn->setGeometry(QRect(450, 320, 51, 23));
    TrainBtn->setText("训练");

    LoadModelBtn = new QPushButton(this);
    LoadModelBtn->setObjectName(QStringLiteral("LoadModelBtn"));
    LoadModelBtn->setGeometry(QRect(510, 320, 61, 23));
    LoadModelBtn->setText("导入模型");

    SaveModelBtn = new QPushButton(this);
    SaveModelBtn->setObjectName(QStringLiteral("SaveModelBtn"));
    SaveModelBtn->setGeometry(QRect(580, 320, 61, 23));
    SaveModelBtn->setText("保存模型");

    TestBtn = new QPushButton(this);
    TestBtn->setObjectName(QStringLiteral("TestBtn"));
    TestBtn->setGeometry(QRect(650, 320, 41, 23));
    TestBtn->setText("测试");

    label = new QLabel(this);
    label->setObjectName(QStringLiteral("label"));
    label->setGeometry(QRect(10, 10, 381, 261));

    //信号
    connect (LoadBtn,SIGNAL(clicked(bool)),this,SLOT( LoadPathText()));
    connect (SaveFileBtn,SIGNAL(clicked(bool)),this,SLOT(SavePathText()));
    connect (TrainBtn,SIGNAL(clicked(bool)),this,SLOT(Train()));
    connect (TestBtn,SIGNAL(clicked(bool)),this,SLOT(Test()));

    SamplePathFileName="G:/RoboSoul/Config/SamplePath.rsc";
    HoGFeatParamFileName="G:/RoboSoul/Config/HoGFeatParam.rsc";
    RFParamFileName="G:/RoboSoul/Config/RFParam.rsc";
    TestPatch="G:/RoboSoul/TestData/BottleSamples/top_good";

    RF=0;
}

TrainWidget::~TrainWidget()
{
    if(RF)
    {
        delete RF;
        RF=0;
    }
}

int TrainWidget::LoadPathText()
{
    QString  fileName=QFileDialog::getOpenFileName();

    QFile file(fileName);
    if(!file.open(QFile::ReadOnly | QFile::Text))
    {
        QMessageBox::warning(this,tr("读取文件"),tr("无法读取文件 %1:\n%2.").arg(fileName).arg(file.errorString()));
        return 0;           //如果打开文件失败，弹出对话框，并返回
    }
    QTextStream in(&file);
    textEdit->setText(in.readAll()); //将文件中的所有内容都写到文本编辑器中

    return 0;
}
int TrainWidget::SavePathText()
{
    QString  fileName=QFileDialog::getOpenFileName();
    QFile file(fileName);
    if(!file.open(QFile::WriteOnly | QFile::Text))
    //以只写方式打开文件，如果打开失败则弹出提示框并返回
    {
        return 0;
    }
        //%1,%2 表示后面的两个arg 参数的值
    QTextStream out(&file);     //新建流对象，指向选定的文件
    out << textEdit->toPlainText();     //将文本编辑器里的内容以纯文本的形式输出到
    QString curFile = QFileInfo(fileName).canonicalFilePath(); //获得文件的标准路径
    setWindowTitle(curFile); //将窗口名称改为现在窗口的路径

    return 0;
}

int TrainWidget::Train()
{

    return 0;
}

int TrainWidget::Train1()
{
    //获取样本路径名
    rsLoadSamplePathAndLabel((char*)SamplePathFileName.c_str(),SamplePath,SamplePathLabel);

    SamplePathLabel[0]=2;

    SamplePathLabel.clear();
    SamplePathLabel.push_back(2);

    SamplePathLabel.push_back(0);

    //生成训练特征
    vector<int> FeatLabel;
    CvRect ROI;
    CvRect ImageROI;
    FeatParam featparam;

    rsLoadHoGParam((char*)HoGFeatParamFileName.c_str(),&featparam,&ROI,&ImageROI);

    CvMat* Data=rsGetHoGFeatSet(SamplePath,SamplePathLabel,FeatLabel,&ROI,&featparam,&ImageROI);

    //随机森林训练
    RF=new RandomForest((char*)RFParamFileName.c_str(),(char*)HoGFeatParamFileName.c_str());

    CvMat* SampleLabel= rsGetLabel(FeatLabel);

    cout<<"Data->cols:"<<Data->cols<<" Data->rows:"<<Data->rows<<endl;

#if 0
    for(int i=0;i<Data->rows;i++)
    {
        for(int j=0;j<Data->cols;j++)
        {
            cout<<rsMat32F(Data,i,j)<<" ";
        }
        cout<<endl;
    }
#endif

    cout<<"Start Train:......"<<endl;
    cout<<RF->Train(Data,SampleLabel)<<endl;
    cout<<"End Train:......"<<endl;

    cvReleaseMat(&Data);
    cvReleaseMat(&SampleLabel);
    return 0;
}

int TrainWidget::Test()
{
    if(!RF)
    {
        RF=new RandomForest((char*)RFParamFileName.c_str(),(char*)HoGFeatParamFileName.c_str());
    }

    vector<int> FeatLabel;
    CvRect ROI;
    CvRect ImageROI;
    FeatParam featparam;

    rsLoadHoGParam((char*)HoGFeatParamFileName.c_str(),&featparam,&ROI,&ImageROI);

    cout<<featparam.HoGBin<<endl;

    QString FileName=QFileDialog::getOpenFileName();

    IplImage* Image=cvLoadImage(FileName.toStdString().c_str());
//"G:/RoboSoul/TestData/BottleSamples/top_good/image31.jpg"
    float* f= rsGetHoGFeat(Image,&ROI,&featparam,&ImageROI);
//    rsNormalizeVector(f,featparam.FeatDim);

     RF->rf->load("G:/RoboSoul/Config/rfmodel.xml");

//    CvMat* Data=rsGenHoGFeatSet(TestPatches,SamplePathLabel,FeatLabel,&ROI,&featparam,&ImageROI);

    CvMat* Feat=cvCreateMat(1,featparam.FeatDim,CV_32FC1);

    cvSetData(Feat,f,sizeof(float)*featparam.FeatDim);

//    for(int i=0;i<Data->rows;i++)
//    {  }

    cout<<RF->Predict(Feat,0)<<endl;

//    cvReleaseMat(&Data);
    cvReleaseMat(&Feat);

    cvReleaseImage(&Image);

    return 0;
}
