#ifndef RSLINE_H
#define RSLINE_H

#include <BasicOperation.h>
#include <imagestitch.h>
#include <iostream>
#include <vector>
#include <string>
using namespace std;

#ifdef __cplusplus
extern "C"
{
#include"lsd.h"
}
#endif

//#define TESTING (1)


int rsLsd(IplImage* Image,CvPoint2D64f * Lines,double Scale=0.58);
int rsForLsd(IplImage* Image,CvPoint2D64f * Lines);
int rsDrawLine(IplImage* Image,CvPoint2D64d* Lines,int N,CvScalar Color);
double rsSumPixel(IplImage* Image,CvRect SumRect,int isAverage=1);
int rsVertLinesDetect(IplImage* Image,vector<int>& XCoord,ProParam* proParam);
int rsDrawVertLines(IplImage* Image,vector<int>& XCoord);
int rsGetXCoord(IplImage* Image,vector<int>& XCoord,ProMem* proMem,ProParam* proParam);
int rsGetYCoord(IplImage* Image,vector<int>& YCoord,ProMem* proMem,ProParam* proParam);
int rsHorLinesDetect(IplImage* Image,vector<int>& YCoord,ProParam* proParam);
int rsDrawHorLines(IplImage* Image,vector<int>& YCoord);

#define ABS(X) ((X)>0?(X):(-X))
#define ON     (1)
#define OFF    (0)

#define STITCH  ON
#define LINE    ON
#define SPOT    ON

int UpdateHeatSpotInfor(vector<HeatSpotParam>& SumHeatSpotInfor,vector<HeatSpotParam>& HeatSpotInfor);
int MarkResHeatSpot(IplImage* Res, vector<HeatSpotParam>& SumHeatSpotInfor,ProParam* proParam);
int GetGlobalCoord( vector<HeatSpotParam>& HeatSpotInfor,CvMat* H);
int MarkResHeatSpot(IplImage* Res, vector<HeatSpotParam>& SumHeatSpotInfor,ProParam* proParam);
int GetGlobalCoord( vector<HeatSpotParam>& HeatSpotInfor,CvMat* H);
int UpdateXCoord(vector<int>& SumXCoord,vector<int>& XCoord,ProMem* proMem);
int GetMinNum(vector<int>& SumXCoord,int GlobalX,int* Dis);
int AddCoordX(vector<int>& SumXCoord,vector<int>& XCoord,ProMem* proMem);
int GetSpotCol(vector<HeatSpotParam>& SumHeatSpotInfor,vector<int> &SumXCoord);
int AddSoptInfor(vector<HeatSpotParam>& SumHeatSpotInfor,vector<HeatSpotParam>& HeatSpotInfor);
int GetSpotRow(vector<HeatSpotParam>& HeatSpotInfor,vector<int> &YCoord);
int GetCol(int GlobalX, vector<int> &SumXCoord);
int GetRow(int Y, vector<int> &YCoord);
int Otsu(IplImage* img);
int HeatSpotDetect(IplImage* Image,CvRect ROI,vector<HeatSpotParam>& heatspotParam,HeatSpotConfig* heatspotConfig,int id,int Pos);

#endif // RSLINE_H
