#ifndef RSFEATCREATOR_H
#define RSFEATCREATOR_H

#include<opencv/cv.h>
#include<opencv/cxcore.h>
#include<opencv/highgui.h>
#include<BasicOperation.h>
#include<FileOper.h>

#include <iostream>
#include <vector>
#include <string>
using namespace std;

#pragma once

// 特征类型
#define RSHOG           (1)     //梯度直方图
#define RSGRAYHIST      (2)     //灰度直方图
#define RSRAW           (3)     //Raw 特征

//---------HOG
#define RSHOGBIN        (8)
#define RSHOGCELLTYPE   (4)

//---------GRAYHIST
#define RSGRAYHISTBIN   (8)

#define RSMETHOD     RSHOG

typedef unsigned int uint;

CvMat* rsGetLabel(vector<int>& L);//ignored

// vector<vector<float>> -> CvMat
CvMat* rsGetDataMat(vector<vector<float>>& data,int dim);

// vector<float> ->CvMat
CvMat* rsVector2Arry(vector<float> &label);

// float* -> vector<float>
int rsArry2Vector(float* d,vector<float>& v,int num);

// CvMat* -> vector<float>
// 要求CvMat为向量
int rsCvMat2Vector(CvMat* d,vector<float>& v,int num);


union FeatParam
{
    struct                  //梯度直方图参数结构
    {
        uint Method;         //特征方法
        uint FeatDim;        //特征维数
        uint HogCellType;    //HoG分块的模式 比如4 5 ...
        CvRect HoGCell[100]; //每四个一组 格式为 x y w h
        uint HoGBin;         //每个Cell的bin数
    };
    struct                  //灰度直方图参数结构
    {
        uint Method;        //特征方法
        uint FeatDim;       //特征维数
        uint CellType;      //分块的模式 比如4 5 ...
        CvRect Cell[100];   //每四个一组 格式为 x y w h
        uint GRAYHISTBin;   //每个Cell的bin数
    };
    struct                  //Raw特征
    {
        uint Method;        // 特征方法
        uint FeatDim;       // 特征维数
        uint Width;         // 宽
        uint Height;        // 高
        CvRect ROI;         //Raw 提取区域
        uint Interpolation;  //插值类型
        uint isNorm;         //是否归一化
    };
};

//------------------HOG------------------//
//生成一个缺省的特征参数结构 FeatParam
//已被脚本方式代替
int rsGetFeatParam(FeatParam* Param, CvRect *ROI=0, void *ExtParam=0);

// 根据ROI计算Cell区域
int rsGetCell(FeatParam *Param, CvRect* ROI, void *ExtParam=0);

//根绝Mag与Ori图像提取指定区域（ROI）的梯度直方图
//注意生成的特征没有进行归一化
#define rsHoGExtractorTest 1
float* rsHoGExtractor(IplImage* Mag, IplImage* Ori, CvRect* ROI, FeatParam* Param, void *ExParam=0);
int rsHoGExtractor(vector<float> &Feat,  IplImage* Mag,IplImage* Ori,CvRect* ROI,FeatParam* Param,void* ExParam=0);

//整合 rsGradient与rsHoGExtractor
//可成为其他特征的函数参数标准
float* rsGetHoGFeat(IplImage* Image,    //提取特征的图像
                    CvRect* ROI,        //提取特征的区域
                    FeatParam* Param,   //特征参数
                    CvRect *ImageROI=0, //图像梯度提取的区域
                    bool Norm=true,     //是否规范化
                    void*ExParam=0);    //预留扩展参数
int rsGetHoGFeat(vector<float> & Feat,
                 IplImage* Image,
                 CvRect* ROI,
                 FeatParam* Param,
                 CvRect* ImageROI=0,
                 void* ExParam=0);


//从文件里导入HoG所需要的特征参数
int rsLoadHoGParam(const char* FileName,FeatParam* Param,CvRect* ROI=0,CvRect* ImageROI=0);


int rsLoadSamplePathAndLabel(char*FileName, vector<string> &PathName, vector<int> &Label);

//生成梯度直方图的特征集合
//目前只适用于二值分类
#define rsCreateHoGFeatSetTest 1
CvMat* rsGenHoGFeatSet(vector<string>  & PathName,   //样本文件夹的路径名
                       IN vector<int>  & Label,      //每个文件夹样本的标签
                       OUT vector<int> & FeatLabel,  //输出每个样本的标签
                       CvRect* ROI,                  //提取特征的区域
                       FeatParam* Param,             //特征参数
                       CvRect *ImageROI=0,           //图像处理的区域
                       bool Norm=true,               //是否对特征规范化
                       void*ExParam=0);              //扩展参数


int rsCreateHoGFeatSet(vector<vector<float>> &data,  // OUT 生成的特征数据
                    vector<float>& SampleLabel,      // OUT 生成的特征标签
                    char* SamplePath,                // IN 一个文件名,该文件每一行是一个存放训练图像样本文件夹的路径
                    char* LabelFileName,             // IN 每一个路径样本对应的标签
                    FeatParam featparam,             // 特征参数
                    CvRect ROI,CvRect ImageROI,
                    bool Norm=true,
                    void* ExtParam=0);

//------------------Gray Histogram------------------//

//从文件里导入灰度直方图特征所需要的特征参数
int rsLoadGrayHistParam(const char* FileName,FeatParam* Param,CvRect* ROI=0,CvRect* ImageROI=0);

//从图像指定ROI区域根据FeatParam参数计算灰度直方图
float* rsGetGrayHistFeat(IplImage* Image, CvRect* ROI,
                         FeatParam* Param, bool Norm=true);

//生成灰度直方图的特征集合
//目前只适用于二值分类
int rsCreateGrayHistFeatSet(vector<vector<float>> &data,  // OUT 生成的特征数据
                    vector<float>& SampleLabel,      // OUT 生成的特征标签
                    char* SamplePath,                // IN 一个文件名,该文件每一行是一个存放训练图像样本文件夹的路径
                    char* LabelFileName,             // IN 每一个路径样本对应的标签
                    FeatParam featparam,             // 特征参数
                    CvRect ROI,CvRect ImageROI,
                    bool Norm=true,
                    void* ExtParam=0);

//------------------Raw------------------//

//从文件里导入Raw特征所需要的特征参数
int rsLoadRawParam(const char* FileName,FeatParam* Param);

CvMat* rsGetRawFeat(IplImage* Image,FeatParam* featparam);

int rsCreateRawFeat(IplImage* Image,FeatParam* featparam,float* Feat);

//生成Raw特征集合
//目前只适用于二值分类
int rsCreateRawFeatSet(vector<vector<float>> &data,  // OUT 生成的特征数据
                    vector<float>& SampleLabel,      // OUT 生成的特征标签
                    char* SamplePath,                // IN 一个文件名,该文件每一行是一个存放训练图像样本文件夹的路径
                    char* LabelFileName,             // IN 每一个路径样本对应的标签
                    FeatParam featparam,             // 特征参数
                    void* ExtParam=0);

CvMat* rsCreateRawFeatSet(CvMat** SampleLabel,
                          char* SamplePath, char* LabelFileName,
                          FeatParam featparam, void* ExtParam);

#endif
