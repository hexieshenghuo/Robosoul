#include "FileOper.h"

int rsGetFileNamesFromPath(char* Path,vector<string> &FileNames,const char* res="jpg")
{
    FileNames.clear();
    struct _finddata_t c_file;//文件结构!
    long hFile;
    string FilePath=Path;//文件路径!
    FilePath+="\\*.";
    FilePath+=res;//"jpg";//

    if( (hFile = _findfirst( FilePath.c_str(), &c_file )) == -1L)
    {
        return -1;
    }
    else
    {
        string FileName=Path;
        FileName+="\\";
        FileName+=c_file.name;
        //FileName+=Res;
        FileNames.push_back(FileName);
        while( _findnext( hFile, &c_file ) == 0 )
        {
            string FileName=Path;
            FileName+="\\";
            FileName+=c_file.name;
            FileNames.push_back(FileName);
        }
    }
    _findclose( hFile );

    return 0;
}

int rsGenSubDataSet(string inPath, string outPath, vector<string> & outFolder, int Num, CvRect *Rect )
{
    vector<string> FileNames;
    int res= rsGetFileNamesFromPath((char*)inPath.c_str(), FileNames);

    //图像循环
    for(int i=0;i<FileNames.size();i++)
    {
        cout<<FileNames[i].c_str()<<endl;
        //输入图像
        IplImage* Image=cvLoadImage(FileNames[i].c_str());
        for(int j=0;j<Num;j++)
        {
            int pos=4*j;
            cvSetImageROI(Image,Rect[i]);
            ostringstream stm;
            stm<<outPath<<"/"<<outFolder[j].c_str()<<"/"<<i<<".jpg";
            string outName=stm.str();
            cout<<outName.c_str()<<endl;
            cvSaveImage(outName.c_str(),Image);
        }
        cvReleaseImage(&Image);
        Image=0;
    }

    return res;
}

int rsGetStringVector(vector<string> &StrVector, const char* FileName)
{
    fstream File(FileName,ios::in);//只读方式打开!
    if (!File.is_open())
    {
        return -1;
    }
    string Str;
    StrVector.clear();//清理!
    for (;getline(File,Str);)//读取一行字符!
    {
        StrVector.push_back(Str);
    }
    File.close();
    return 0;
}

int rsLoadBackgroundDetectParam(char* FileName,CvRect* ImageROI,CvRect* BackDetectROI,double* Threshold, void* ExtParam)
{
    if(!FileName)
    {
        return -1;
    }

    //读入配置文件每行的字符串
    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    int Num=Strs.size();

    //ROI
    if(ImageROI)
    {
        sscanf(Strs[0].c_str(),"ImageROI: x %d, y %d, width %d, height %d",&ImageROI->x,&ImageROI->y,&ImageROI->width,&ImageROI->height);
    }

    int BackDetectNum=Num-3;

    //BackDetectROI
    if(BackDetectROI)
    {
        for(int i=0;i<BackDetectNum;i++)
        {
            sscanf(Strs[i+1].c_str(),"BackDetectROI: x %d, y %d, width %d, height %d",&BackDetectROI[i].x,&BackDetectROI[i].y,&BackDetectROI[i].width,&BackDetectROI[i].height);
        }
    }

    //检测阈值
    if(Threshold)
    {
        sscanf(Strs[Num-2].c_str(),"Threshold : %lf",Threshold);
    }

    if(ExtParam)
    {
        sscanf(Strs[Num-1].c_str(),"BinThres : %lf",(double*)ExtParam);
    }

    return BackDetectNum;
}

int rsLoadComName(char* FileName,string& ComName)
{
    vector<string> Str;
    rsGetStringVector(Str,FileName);

    ComName=Str[0];

    return 0;
}

int rsLoadDelayTime(char* FileName,long* ms1,long* ms2,long *shunton,long *shuntoff)
{
    if(!FileName)
    {
        return -1;
    }

    //读入配置文件每行的字符串
    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    int Num=Strs.size();

    //ms
    if(ms1)
    {
        sscanf(Strs[0].c_str(),"ms1 : %ld",ms1);
    }

    //ms
    if(ms2)
    {
        sscanf(Strs[1].c_str(),"ms2 : %ld",ms2);
    }

    if(shunton)
    {
        sscanf(Strs[2].c_str(),"ShuntOnTime : %ld",shunton);
    }

    if(shuntoff)
    {
        sscanf(Strs[3].c_str(),"ShuntOffTime : %ld",shuntoff);
    }

    return 0;
}
