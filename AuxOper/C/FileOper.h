#include <vector>
#include <string>
#include <fstream>
#include <io.h>
using namespace std;

//OpenCV
#include <opencv/cv.h>
#include <opencv/cxcore.h>
#include <opencv/highgui.h>

#pragma once

#ifndef IN
#define IN
#endif

#ifndef OUT
#define OUT
#endif

//从一个路径得到文件名集合!
int rsGetFileNamesFromPath(char* Path,vector<string> &FileNames,const char* res);

// 根据文件夹中数据生成不同图像区域的子数据文件集合
int rsGenSubDataSet(string inPath, string outPath, vector<string> & outFolder, int Num, CvRect* Rect);

//从一个文件中得到一个字符向量!
int rsGetStringVector(vector<string> &StrVector, const char* FileName);


//获得背景检测所需参数
int rsLoadBackgroundDetectParam(char* FileName, CvRect* ImageROI, CvRect *BackDetectROI, double* Threshold, void* ExtParam=0);

int rsLoadComName(char* FileName, string &ComName);

int rsLoadDelayTime(char* FileName, long *ms1, long *ms2, long *shunton, long *shuntoff);
