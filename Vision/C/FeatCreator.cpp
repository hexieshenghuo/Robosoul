#include "FeatCreator.h"


int rsGetFeatParam(FeatParam* Param,CvRect* ROI,void* ExtParam)
{
    Param->HoGBin=RSHOGBIN;
    Param->HogCellType=RSHOGCELLTYPE;
    Param->Method=RSMETHOD;
    Param->FeatDim=Param->HoGBin*Param->HogCellType;
    memset(Param->HoGCell,0,sizeof(CvRect)*12);

    if(ROI)
    {
        rsGetCell(Param,ROI,ExtParam);
    }

    return 0;
}

int rsGetCell(FeatParam *Param,CvRect* ROI,void* ExtParam)
{  
    if(ExtParam)
    {
        return -1;
    }

    int ColNum=0;
    int RowNum=0;
    uint dx=0;//每一块的x方向的Cell长度
    uint dy=0;    //每一块的y方向的Cell长度
    int x=ROI->x;
    int y=ROI->y;
    switch(Param->HogCellType)
    {
    case 1:
        ColNum=1;
        RowNum=1;
        Param->HoGCell[0].x=x;
        Param->HoGCell[0].y=y;
        Param->HoGCell[0].width=ROI->width;
        Param->HoGCell[0].height=ROI->height;
        break;
    case 2:
        ColNum=1;
        RowNum=2;
        break;
    case 3:
        ColNum=1;
        RowNum=3;
        break;
    case 4:
        ColNum=2;
        RowNum=2;
        dx=ROI->width/ColNum;
        dy=ROI->height/RowNum;

        Param->HoGCell[0].x=x;
        Param->HoGCell[0].y=y;
        Param->HoGCell[0].width=dx;
        Param->HoGCell[0].height=dy;

        Param->HoGCell[1].x=x+dx;
        Param->HoGCell[1].y=y;
        Param->HoGCell[1].width=ROI->width-dx;
        Param->HoGCell[1].height=dy;

        Param->HoGCell[2].x=x;
        Param->HoGCell[2].y=y+dy;
        Param->HoGCell[2].width=dx;
        Param->HoGCell[2].height=ROI->height-dy;

        Param->HoGCell[3].x=x+dx;
        Param->HoGCell[3].y=y+dy;
        Param->HoGCell[3].width=ROI->width-dx;
        Param->HoGCell[3].height=ROI->height-dy;
        break;
    case 5:
        ColNum=2;
        RowNum=2;
        dx=ROI->width/ColNum;
        dy=ROI->height/RowNum;

        Param->HoGCell[0].x=x;
        Param->HoGCell[0].y=y;
        Param->HoGCell[0].width=dx;
        Param->HoGCell[0].height=dy;

        Param->HoGCell[1].x=x+dx;
        Param->HoGCell[1].y=y;
        Param->HoGCell[1].width=ROI->width-dx;
        Param->HoGCell[1].height=dy;

        Param->HoGCell[2].x=x;
        Param->HoGCell[2].y=y+dy;
        Param->HoGCell[2].width=dx;
        Param->HoGCell[2].height=ROI->height-dy;

        Param->HoGCell[3].x=x+dx;
        Param->HoGCell[3].y=y+dy;
        Param->HoGCell[3].width=ROI->width-dx;
        Param->HoGCell[3].height=ROI->height-dy;

        dx=ROI->width/4;
        dy=ROI->height/4;

        Param->HoGCell[4].x=x+dx;
        Param->HoGCell[4].y=y+dy;
        Param->HoGCell[4].width=dx*2;
        Param->HoGCell[4].height=dy*2;

        break;
    case 6:
        ColNum=2;
        RowNum=3;
        break;
    case 7:
        ColNum=1;
        RowNum=7;
    case 8:
        ColNum=2;
        RowNum=4;
        break;
    case 9:
        ColNum=3;
        RowNum=3;
        break;
    case 10:
        ColNum=2;
        RowNum=5;
        break;
    case 11:
        ColNum=1;
        RowNum=11;
        break;
    case 12:
        ColNum=3;
        RowNum=4;
        break;
    case 13:
        ColNum=1;
        RowNum=13;
        break;
    case 14:
        ColNum=2;
        RowNum=7;
        break;
    case 15:
        ColNum=3;
        RowNum=5;
        break;
    case 16:
        ColNum=4;
        RowNum=4;
        break;
    case 17:
        ColNum=1;
        RowNum=17;
        break;
    case 18:
        ColNum=3;
        RowNum=6;
        break;
    case 19:
        ColNum=1;
        RowNum=19;
        break;
    case 20:
        ColNum=4;
        RowNum=5;
        break;
    case 21:
        ColNum=3;
        RowNum=7;
        break;
    case 22:
        ColNum=2;
        RowNum=11;
        break;
    case 23:
        ColNum=1;
        RowNum=23;
        break;
    case 24:
        ColNum=4;
        RowNum=6;
        break;
    case 25:
        ColNum=5;
        RowNum=5;
        break;
    case 26:
        ColNum=2;
        RowNum=13;
        break;
    case 27:
        ColNum=3;
        RowNum=7;
        break;
    case 36:
        ColNum=6;
        RowNum=6;
        break;
    case 40:
        ColNum=5;
        RowNum=8;
        break;
    case 42:
        ColNum=6;
        RowNum=7;
        break;
    case 48:
        ColNum=6;
        RowNum=8;
        break;
    case 56:
        ColNum=7;
        RowNum=8;
        break;
    case 64:
        ColNum=8;
        RowNum=8;
        break;
    case 72:
        ColNum=8;
        RowNum=9;
        break;
    case 81:
        ColNum=9;
        RowNum=9;
        break;
    case 100:
        ColNum=10;
        RowNum=10;
        break;
    default:
        break;
    }

    dx=ROI->width/ColNum;
    dy=ROI->height/RowNum;

    if(Param->HogCellType!=5 ||
       Param->HogCellType==2 ||
       Param->HogCellType==3 ||
       Param->HogCellType==6 ||
       Param->HogCellType==8 ||
       Param->HogCellType==9 ||
       Param->HogCellType==10||
       Param->HogCellType==12||
       Param->HogCellType==14||
       Param->HogCellType==15)
    {
        for(int i=0;i<RowNum;i++)
        {
            for(int j=0;j<ColNum;j++)
            {
                Param->HoGCell[i*ColNum+j].x=x+j*dx; //col
                Param->HoGCell[i*ColNum+j].y=y+i*dy; //row
                if(j==ColNum-1)
                {
                    Param->HoGCell[i*ColNum+j].width=ROI->width-j*dx;
                }
                else
                {
                    Param->HoGCell[i*ColNum+j].width=dx;
                }
                if(i==RowNum-1)
                {
                    Param->HoGCell[i*ColNum+j].height=ROI->height-i*dy;
                }
                else
                {
                    Param->HoGCell[i*ColNum+j].height=dy;
                }
            }
        }
    }

    if(!(ColNum&&RowNum))
    {
        return -1;
    }
    return 0;
}



float* rsHoGExtractor(IplImage* Mag,IplImage* Ori,CvRect* ROI,FeatParam* Param,void* ExParam)
{
    float* Feat=new float[Param->FeatDim];
    memset(Feat,0,sizeof(float)*Param->FeatDim);//将开辟的Feat数组中值置为0

    double d=360.0/Param->HoGBin;
    for (int i=0;i<Param->HogCellType;i++)
    {
        //计算Cell的起止点
        int Sx=Param->HoGCell[i].x;
        int Ex=Param->HoGCell[i].x+Param->HoGCell[i].width;
        int Sy=Param->HoGCell[i].y;
        int Ey=Param->HoGCell[i].y+Param->HoGCell[i].height;

        //特征槽的偏移量
        uint Pos=i*Param->HoGBin;
        for(int x=Sx;x<Ex;x++)
        {
            for(int y=Sy;y<Ey;y++)
            {
               float mag=rsImage32F1(Mag,x,y);
               float angle=rsImage32F1(Ori,x,y);

               //计算直方图Bin号
               uint BinNum= cvFloor(angle/d)%Param->HoGBin;
               Feat[Pos+BinNum]+=mag;
            }
        }
    }
    return Feat;
}

int rsHoGExtractor(vector<float> &Feat,  IplImage* Mag,IplImage* Ori,CvRect* ROI,FeatParam* Param,void* ExParam)
{
    Feat.clear();
    vector<float> f(Param->FeatDim,0);

    double d=360.0/Param->HoGBin;
    for (uint i=0;i<Param->HogCellType;i++)
    {
        //计算Cell的起止点
        int Sx=Param->HoGCell[i].x;
        int Ex=Param->HoGCell[i].x+Param->HoGCell[i].width;
        int Sy=Param->HoGCell[i].y;
        int Ey=Param->HoGCell[i].y+Param->HoGCell[i].height;

        //特征槽的偏移量
        uint Pos=i*Param->HoGBin;
        for(int x=Sx;x<Ex;x++)
        {
            for(int y=Sy;y<Ey;y++)
            {
               float mag=rsImage32F1(Mag,x,y);
               float angle=rsImage32F1(Ori,x,y);

               //计算直方图Bin号
               uint BinNum= cvFloor(angle/d)%Param->HoGBin;
               f[Pos+BinNum]=f[Pos+BinNum] +mag;
            }
        }
    }

    Feat=f;

    return 0;
}

float* rsGetHoGFeat(IplImage* Image,CvRect* ROI,FeatParam* Param,CvRect* ImageROI,bool Norm,void* ExParam)
{
    IplImage* Mag;
    IplImage* Ori;
    CvRect* roiRect=0;
    if(ImageROI)
    {
        roiRect=ImageROI;
    }
    else
    {
        roiRect=ROI;
    }

cvSetImageROI(Image,roiRect[0]);
    rsGradient(Image,&Mag,&Ori,roiRect,ExParam);
    float* Feat= rsHoGExtractor(Mag,Ori,ROI,Param,ExParam);
cvResetImageROI(Image);

    cvReleaseImage(&Mag);
    cvReleaseImage(&Ori);

    if(Norm)
    {
        rsNormalizeVector(Feat,Param->FeatDim);
    }

    return Feat;
}

int rsGetHoGFeat(vector<float> & Feat,IplImage* Image,CvRect* ROI,FeatParam* Param,CvRect* ImageROI ,void* ExParam)
{
    IplImage* Mag;
    IplImage* Ori;
    CvRect* roiRect=0;
    if(ImageROI)
    {
        roiRect=ImageROI;
    }
    else
    {
        roiRect=ROI;
    }

cvSetImageROI(Image,roiRect[0]);
    rsGradient(Image,&Mag,&Ori,roiRect,ExParam);
    rsHoGExtractor(Feat,Mag,Ori,ROI,Param,ExParam);
cvResetImageROI(Image);

    cvReleaseImage(&Mag);
    cvReleaseImage(&Ori);

    return 0;
}

int rsLoadSamplePathAndLabel(char*FileName, vector<string> &PathName, vector<int> &Label)
{
    PathName.clear();
    Label.clear();

    vector<string> Str;
    rsGetStringVector(Str, FileName);

    for(int i=0;i<Str.size();i++)
    {
        int label=1;
        char str[100]={0};
        sscanf(Str[i].c_str(),"%s : %d",str,&label);
        string s=str;
        PathName.push_back(s);
        Label.push_back(label);
#if 1
        string c=PathName[i];
        cout<<c.c_str()<<" "<<Label[i]<<endl;
#endif
    }

    return 0;
}

CvMat* rsGenHoGFeatSet(vector<string> &PathName, vector<int> &Label,vector<int> &FeatLabel,CvRect* ROI,FeatParam* Param,CvRect *ImageROI,bool Norm,void*ExParam)
{
    FeatLabel.clear();
    int PathNum=PathName.size();
    CvMat* FeatSet=0;
    CvMat* Feat=cvCreateMat(1,Param->FeatDim,CV_32FC1);
    for(int i=0;i<PathNum;i++)
    {
        vector<string> FileName;
        rsGetFileNamesFromPath((char*)PathName[i].c_str(),FileName,"jpg");
        int FileNum=FileName.size();
        //处理图像
        for(int j=0;j<FileNum;j++)
        {
            IplImage* Image=cvLoadImage((char*)FileName[j].c_str());

            float* f=rsGetHoGFeat(Image,ROI,Param,ImageROI,ExParam);
            if(Norm)
            {
                rsNormalizeVector(f,Param->FeatDim);
            }
            cvSetData(Feat,f,sizeof(float)*Feat->cols);

            FeatSet=rsComposeMat(FeatSet,Feat,&FeatSet,VERTICAL);

            FeatLabel.push_back(Label[i]);

            delete[] f;
        }
        FileName.clear();
    }
    cvReleaseMat(&Feat);
    return FeatSet;
}

int rsLoadHoGParam(const char* FileName,FeatParam* Param,CvRect* ROI,CvRect* ImageROI)
{
    if(!FileName)
    {
        return 1;
    }

    //读入配置文件每行的字符串
    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    //ROI
    if(ROI)
    {
        sscanf(Strs[1].c_str(),"ROI: x %d, y %d, width %d, height %d",&ROI->x,&ROI->y,&ROI->width,&ROI->height);
    }

    //ImageROI
    if(ImageROI)
    {
        sscanf(Strs[2].c_str(),"ImageROI: x %d, y %d, width %d, height %d",&ImageROI->x,&ImageROI->y,&ImageROI->width,&ImageROI->height);
    }

    //FeatParam
    if(Param)
    {
        sscanf(Strs[0].c_str(),"Param: HoGBin %d, HogCellType %d",&Param->HoGBin,&Param->HogCellType);
        Param->Method=RSHOG;
        Param->FeatDim=Param->HoGBin*Param->HogCellType;
        rsGetCell(Param,ROI);
    }
    return 0;
}

#if 1
#define BitType  float
#define RSBIT  CV_32FC1
#else
#define BitType int
#define RSBIT  CV_32SC1
#endif

int rsCreateHoGFeatSet(vector<vector<float>> &data,vector<float>& SampleLabel,char* SamplePath, char* LabelFileName,
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
//      cout<<"Label"<<i<<":"<<PathLabel[i]<<endl;
    }

    //---------获得特征数据和样本标签
    vector<string> SampleFilePath;//样本文件夹字符串

    rsGetStringVector(SampleFilePath,SamplePath);
    int PathNum=SampleFilePath.size();

    rsfor(i,PathNum)
    {
        vector<string> FileNames;

        rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
        int SampleNum=FileNames.size();
        for(int j=0;j<SampleNum;j++)
        {
            IplImage* Image=cvLoadImage(FileNames[j].c_str());

            float* f= rsGetHoGFeat(Image,&ROI,&featparam,&ImageROI,true);
            if(Norm)
            {
                rsNormalizeVector(f,featparam.FeatDim);
            }

            //特征数据格式转换
            vector<float> v;
            rsArry2Vector(f, v,featparam.FeatDim);

            delete[] f;
            f=0;

            data.push_back(v);
            SampleLabel.push_back((float)PathLabel[i]);

            cvReleaseImage(&Image);
            Image=0;
        }

        FileNames.clear();
    }
    return 0;
}

CvMat* rsGetDataMat(vector<vector<float>>& data,int dim)
{
    int row=data.size();
    CvMat* Data=cvCreateMat(row,dim,CV_32FC1);
    for(int i=0;i<row;i++)
    {
        vector<float>d= data[i];
        for(int j=0;j<dim;j++)
        {
            rsMat32F(Data,i,j)=d[j];
        }
    }
    return Data;
}

CvMat* rsVector2Arry(vector<float> &label)
{
    int num=label.size();
    CvMat* Label=cvCreateMat(num,1,CV_32FC1);
    for(int i=0;i<num;i++)
    {
        rsMat32F(Label,i,0)=label[i];
    }
    return Label;
}

int rsArry2Vector(float* d,vector<float>& v,int num)
{
    for(int i=0;i<num;i++)
    {
        v.push_back(d[i]);
    }
    return 0;
}

// CvMat* -> vector<float>
int rsCvMat2Vector(CvMat* d,vector<float>& v,int num)
{
    for(int i=0;i<num;i++)
    {
        float val=rsMat32F(d,0,i);
        v.push_back(val);
    }

    return 0;
}

CvMat* rsGetLabel(vector<int>& L)
{
    int Num=L.size();
    BitType* d=new BitType[Num];
    for(int i=0;i<Num;i++)
    {
        d[i]=L[i];
    }

    CvMat* Label=cvCreateMat(Num,1,RSBIT);
    cvSetData(Label,d,sizeof(BitType));

    delete[] d;
    return Label;
}


int rsLoadGrayHistParam(const char* FileName,FeatParam* Param,CvRect* ROI,CvRect* ImageROI)
{
    if(!FileName)
    {
        return 1;
    }

    //读入配置文件每行的字符串
    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    //ROI
    if(ROI)
    {
        sscanf(Strs[1].c_str(),"ROI: x %d, y %d, width %d, height %d",&ROI->x,&ROI->y,&ROI->width,&ROI->height);
    }

    //ImageROI
    if(ImageROI)
    {
        sscanf(Strs[2].c_str(),"ImageROI: x %d, y %d, width %d, height %d",&ImageROI->x,&ImageROI->y,&ImageROI->width,&ImageROI->height);
    }

    //FeatParam
    if(Param)
    {
        sscanf(Strs[0].c_str(),"Param: Bin %d, CellType %d",&Param->GRAYHISTBin,&Param->CellType);
        Param->Method=RSGRAYHIST;
        Param->FeatDim=Param->GRAYHISTBin*Param->CellType;
        rsGetCell(Param,ROI);
    }
    return 0;
}

float* rsGetGrayHistFeat(IplImage* Image,CvRect* ROI,FeatParam* Param,bool Norm)
{
    if(!Image)
    {
        return 0;
    }

    IplImage* img=Image;
    if(Image->nChannels>1)
    {
        img=cvCreateImage(cvSize(Image->width,Image->height),Image->depth,1);
        cvCvtColor(Image,img,CV_BGR2GRAY);
    }

    float* Feat=new float[Param->FeatDim];
    memset(Feat,0,sizeof(float)*Param->FeatDim);

    double d=255.0/Param->GRAYHISTBin;

    for (int i=0;i<Param->CellType;i++)
    {
        //计算Cell的起止点
        int Sx=Param->Cell[i].x;
        int Ex=Param->Cell[i].x+Param->Cell[i].width;
        int Sy=Param->Cell[i].y;
        int Ey=Param->Cell[i].y+Param->Cell[i].height;

        //特征槽的偏移量
        uint Pos=i*Param->HoGBin;
        for(int x=Sx;x<Ex;x++)
        {
            for(int y=Sy;y<Ey;y++)
            {
               //计算直方图Bin号
               double g=rsImage8U1(img,x,y);
               uint BinNum= cvFloor(g/d)%Param->GRAYHISTBin;
               Feat[Pos+BinNum]+=1.0;
            }
        }
    }

    if(Image->nChannels>1)
    {
        cvReleaseImage(&img);
        img=0;
    }

    if(Norm)
    {
        rsNormalizeVector(Feat,Param->FeatDim);
    }

    return Feat;
}

int rsCreateGrayHistFeatSet(vector<vector<float>> &data,vector<float>& SampleLabel,char* SamplePath, char* LabelFileName,
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
//      cout<<"Label"<<i<<":"<<PathLabel[i]<<endl;
    }

    //---------获得特征数据和样本标签
    vector<string> SampleFilePath;//样本文件夹字符串

    rsGetStringVector(SampleFilePath,SamplePath);
    int PathNum=SampleFilePath.size();

    rsfor(i,PathNum)
    {
        vector<string> FileNames;

        rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
        int SampleNum=FileNames.size();
        for(int j=0;j<SampleNum;j++)
        {
            IplImage* Image=cvLoadImage(FileNames[j].c_str());

            float *f=rsGetGrayHistFeat(Image,&ROI,&featparam,Norm);

            //特征数据格式转换
            vector<float> v;
            rsArry2Vector(f, v,featparam.FeatDim);

            delete[] f;
            f=0;

            data.push_back(v);
            SampleLabel.push_back((float)PathLabel[i]);

            cvReleaseImage(&Image);
            Image=0;
        }

        FileNames.clear();
    }
    return 0;
}

int rsLoadRawParam(const char* FileName,FeatParam* Param)
{
    if(!FileName)
    {
        return RS_ERROR;
    }

    //读入配置文件每行的字符串
    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    //FeatParam
    if(Param)
    {
        sscanf(Strs[0].c_str(),"Param: Width %d, Height %d",&Param->Width,&Param->Height);
        Param->Method=RSRAW;
        Param->FeatDim=Param->Width*Param->Height;

        sscanf(Strs[1].c_str(),"ROI: x %d, y %d, width %d, height %d",&Param->ROI.x,&Param->ROI.y,&Param->ROI.width,&Param->ROI.height);

        sscanf(Strs[2].c_str(),"Interpolation: %d",&Param->Interpolation);

        sscanf(Strs[3].c_str(),"isNorm: %d",&Param->isNorm);

    }
    else
    {
        return RS_ERROR;
    }
    return 0;
}

CvMat* rsGetRawFeat(IplImage* Image,FeatParam* featparam)
{
    if(!Image)
    {
        return 0;
    }
    IplImage* Gray=Image;

    if(Image->nChannels>1)
    {
        Gray=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_8U,1);
        cvCvtColor(Image,Gray,CV_BGR2GRAY);
    }

    //提取Raw特征区域
    CvMat* SubMat=cvCreateMat(featparam->ROI.height,featparam->ROI.width,CV_8UC1);
    cvGetSubRect(Gray,SubMat,featparam->ROI);

    //转32位灰度
    CvMat* SubMat32=cvCreateMat(featparam->ROI.height,featparam->ROI.width,CV_32FC1);
    cvConvertScale(SubMat,SubMat32,1.0/255.0);

    //缩放
    CvMat* Data=cvCreateMat(featparam->Height,featparam->Width,CV_32FC1);
    cvResize(SubMat32,Data,featparam->Interpolation);

    //转成1×N维向量
    CvMat* Feat=cvCreateMat(1,featparam->FeatDim,CV_32FC1);
    cvReshape(Data,Feat,0,1);

    //归一化
    if(featparam->isNorm)
    {

    }

    //释放内存
    if(Image->nChannels>1)
    {
        cvReleaseImage(&Gray);
        Gray=0;
    }

    if(SubMat)
    {
        cvReleaseMat(&SubMat);
    }
    if(SubMat32)
    {
        cvReleaseMat(&SubMat32);
    }
    if(Data)
    {
        cvReleaseMat(&Data);
    }

    return Feat;
}

int rsCreateRawFeatSet(vector<vector<float>> &data,vector<float>& SampleLabel,char* SamplePath, char* LabelFileName,
                  FeatParam featparam, void* ExtParam)
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

            CvMat *f=rsGetRawFeat(Image,&featparam);

            //特征数据格式转换
            vector<float> v;
            rsCvMat2Vector(f, v,(int)featparam.FeatDim);

            cvReleaseMat(&f);
            f=0;

            data.push_back(v);
            SampleLabel.push_back((float)PathLabel[i]);

            cvReleaseImage(&Image);
            Image=0;
        }

        FileNames.clear();
    }
    return 0;
}

CvMat* rsCreateRawFeatSet(CvMat** SampleLabel,char* SamplePath, char* LabelFileName,
                  FeatParam featparam, void* ExtParam)
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
    }

    //---------获得特征数据和样本标签
    vector<string> SampleFilePath;//样本文件夹字符串
    rsGetStringVector(SampleFilePath,SamplePath);
    int PathNum=SampleFilePath.size();

    //计算总样本数
    int SampleSumCount=0;  //样本总数
    for(int i=0;i<PathNum;i++)
    {
        vector<string> FileNames;
        rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
        int SampleNum=FileNames.size();
        SampleSumCount+=SampleNum;
    }

    //创建数据内存
//    float *d=new float[SampleSumCount*featparam.FeatDim];
    CvMat* Data=cvCreateMat(SampleSumCount,featparam.FeatDim,CV_32FC1);
    CvMat* Label=cvCreateMat(SampleSumCount,1,CV_32FC1);
    cvZero(Data);
    cvZero(Label);

    int Count=0;
    float* Feat=new float[featparam.FeatDim];

    for(int i=0;i<PathNum;i++)
    {
        vector<string> FileNames;

        rsGetFileNamesFromPath((char*)SampleFilePath[i].c_str(),FileNames,"jpg");
        int SampleNum=FileNames.size();
        for(int j=0;j<SampleNum;j++)
        {
            IplImage* Image=cvLoadImage(FileNames[j].c_str());
//            CvMat *Feat=rsGetRawFeat(Image,&featparam);
            rsCreateRawFeat(Image,&featparam,Feat);

            //添加特征和标签分别到Data和Label中
            memcpy(Data->data.ptr+Count*Data->step,
                   Feat,
                   sizeof(float)*Data->cols);
            rsMat32F(Label,Count,0)=(float)PathLabel[i];


            //释放内存
            cvReleaseImage(&Image);
            Image=0;
            Count++;
        }

        FileNames.clear();
    }
    delete[] Feat;
    Feat=0;

    SampleLabel[0]=Label;
    return Data;
}

int rsCreateRawFeat(IplImage* Image,FeatParam* featparam,float* Feat)
{
    if(!Image)
    {
        return 0;
    }
    IplImage* Gray=Image;

    if(Image->nChannels>1)
    {
        Gray=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_8U,1);
        cvCvtColor(Image,Gray,CV_BGR2GRAY);
    }

    //提取Raw特征区域
    CvMat* SubMat=cvCreateMat(featparam->ROI.height,featparam->ROI.width,CV_8UC1);
    cvGetSubRect(Gray,SubMat,featparam->ROI);

    //转32位灰度
    CvMat* SubMat32=cvCreateMat(featparam->ROI.height,featparam->ROI.width,CV_32FC1);
    cvConvertScale(SubMat,SubMat32,1.0/255.0);

    //缩放
    CvMat* Data=cvCreateMat(featparam->Height,featparam->Width,CV_32FC1);
    cvResize(SubMat32,Data,featparam->Interpolation);

    //转成1×N维向量
    memcpy(Feat,Data->data.fl,sizeof(float)*featparam->FeatDim);

    //归一化
    if(featparam->isNorm)
    {

    }

    //释放内存
    if(Image->nChannels>1)
    {
        cvReleaseImage(&Gray);
        Gray=0;
    }

    if(SubMat)
    {
        cvReleaseMat(&SubMat);
    }
    if(SubMat32)
    {
        cvReleaseMat(&SubMat32);
    }
    if(Data)
    {
        cvReleaseMat(&Data);
    }

    return 0;
}
