#include <BasicOperation.h>
#include <FileOper.h>

struct HeatSpotConfig //该结构里的参数可由外部文件获得
{
    int threshold;//热斑检测二值化阈值
    int EDnum; //腐蚀膨胀次数
};

struct HeatSpotParam
{
   int x;          // 当前图像的X位置
   int y;          // 当前图像的Y位置
   int Radius;

   int GlobalX;    //全局坐标
   int GlobalY;

   int Row;        //
   int Col;        //
   int ID;
   int Pos;

   float H[3][3];
};

// 光伏图像拼接所需常量参数
struct ProParam
{
    //
    CvSize ImageSize;
    //Harris
    double QualityLevel;
    double MinDis;
    int BlockSize;
    double K;
    int UseHarris;
    CvRect HarrisROI;
    int PointMaxNum;

    // Subpixel
    CvTermCriteria SubTerm;
    int SubSize;

    // LK
    int LKSize;
    int LKLevel;
    CvTermCriteria LKTerm;
    int LKFlag;

    // Homography
    int HomoMethod;
    double ransacThres;

    // Stitching
    CvSize ResSize;
    CvRect StitchROI;
    float OffsetY;

    //直线检测
    int VertShortStep;      //小步检测
    int VertLongStep;       //大步检测
    int VertWidth;          //垂直方向直线检测区域的宽度
    int VertHeight;         //垂直方向直线检测区域的高度
    CvRect VertRect;        //垂直直线的检测域
    double VertThres;       //垂直阈值
    int xOrder;             //Sobel X阶数
    double VertLsdScale;
    double VertLsdGain;
    int VertMethod;


    int HorShortStep;      //小步检测
    int HorLongStep;       //大步检测
    int HorWidth;          //垂直方向直线检测区域的宽度
    int HorHeight;         //垂直方向直线检测区域的高度
    CvRect HorRect;        //垂直直线的检测域
    double HorThres;       //垂直阈值
    int yOrder;            //Sobel X阶数
    double HorLsdScale;
    double HorLsdGain;
    int HorMethod;

    // 热斑检测
    CvRect SpotRect;     //热斑检测区域
    HeatSpotConfig HeatConfig;

};

// 光伏图像拼接所需内存变量
// 缓存与固定值内存 由OpenCV函数处理
struct ProMem
{
    // Corners
    CvMat* Mask;        //提取角点的区域
//    IplImage* Mask;
    IplImage* Temp1;
    IplImage* Temp2;

    // L-K 缓存
    char* Status;
    IplImage* PrevPyramid;
    IplImage* CurrPyramid;

    // Stitch
    IplImage* StitchTemp;
    IplImage* StitchPre;  //3Channel
    IplImage* StitchCurr; //3Channel

    //------视频循环拼接
    //变换矩阵
    CvMat* Ho2r;//=cvCreateMat(3,3,CV_32FC1);// old to Res
    CvMat* Hn2o;//=cvCreateMat(3,3,CV_32FC1);// new to old
    CvMat* Hn2r;//=cvCreateMat(3,3,CV_32FC1);// new to Res


    CvPoint2D32f* Ps1;//=new CvPoint2D32f[proParam->PointMaxNum];
    CvPoint2D32f* Ps2;//=new CvPoint2D32f[proParam->PointMaxNum];
    CvPoint2D32f* Ps3;//=new CvPoint2D32f[proParam->PointMaxNum];


    IplImage* PreImage;//=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);
    IplImage* CurrImage;//=cvCreateImage(cvSize(Width,Height),IPL_DEPTH_8U,3);

    IplImage* grayPre;// = cvCreateImage(cvSize(PreImage->width,PreImage->height), IPL_DEPTH_8U,1);
    IplImage* grayCurr;// = cvCreateImage(cvSize(PreImage->width,PreImage->height), IPL_DEPTH_8U,1);

    IplImage* Res;

    int DirectFlag;

    //直线检测
    IplImage* LineImage;//=cvCreateImage(cvSize(Temp->width,Temp->height),IPL_DEPTH_8U,3);
    IplImage* LineGray;//=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_8U,1);
    IplImage* LineImage64;//=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_64F,1);
    IplImage* LineSum64;//=cvCreateImage(cvSize(Image->width,Image->height),IPL_DEPTH_64F,1);
    IplImage* LineSum;//=cvCreateImage(cvSize(Temp->width,Temp->height),IPL_DEPTH_8U,3);

    CvPoint2D64d* Lines;//=new CvPoint2D64d[1000];
};

// 由自定义函数处理变量
struct ProVal
{
    // Corner
    int CornerNum;

    //Stitch
};

// 计算角点
// img: 灰度图像
int rsCorners(IplImage* img, CvPoint2D32f* Points,CvArr* Mask,IplImage* Temp1,IplImage* Temp2,ProParam* proparam);

int rsCorners(IplImage* img, CvPoint2D32f* Points,ProMem* proMem, ProParam* proParam );

int rsSubPixel(IplImage* img,CvPoint2D32f* Corners,int CornerNum,ProParam* proParam);

// 计算单点的单应矩阵变换
// Pdst=H Psrc
int rsPointTrans(CvPoint2D32f* Psrc, CvPoint2D32f *Pdst, CvMat* H);

// 计算点集的单应矩阵变换
// Pdst=H Psrc  Psrc → Pdst
int rsPsTrans(CvPoint2D32f *Psrc, CvPoint2D32f *Pdst, int Num, CvMat* H);

// 导入参数
int rsLoadProParam(const char* FileName,ProParam* proparam,CvSize* ImageSize=0);

// 初始化拼接所需内存
int rsInitProMem(ProParam* proParam,ProMem* proMem);
int rsReleaseProMem(ProMem** promem);

// L-K稀疏光流
int rsLK(IplImage* PrevImage, IplImage* CurrImage, CvPoint2D32f *PrePoints, CvPoint2D32f *CurrPoints,int PointNum, ProMem* proMem, ProParam* proParam);

// 显示角点数值
int rsDisplayPoints(CvPoint2D32f* P1, CvPoint2D32f* P2, int PointsNum, int Type=0);

// 显示单应矩阵H
int rsDisplayH(CvMat* H);

// 简化单应矩阵，令R=I sx=0 sy=0 sx: M(2,0) sy: M(2,1)
int rsSimpleH(CvMat* H);

// 根据两组点对计算单应矩阵H
// H: Psrc->Pdst
// si·Pdst = H·Psrc
int rsGetH(CvPoint2D32f* Psrc, CvPoint2D32f* Pdst, int PointsNum, CvMat* H, ProParam* proParam);

// 图像拼接
// return 拼接结果图像指针
// H: ImageStitched -> Base
// 目前只支持横向
#define RS_STITCH_LEFT    (0)   // 从左边开始拼接
#define RS_STITCH_RIGHT   (1)   // 从右边开始拼接
IplImage* rsStitch(IplImage* Base, IplImage* ImageStitched, CvMat* H,
                   IplImage* Res=0, ProParam *proParam=0,
                   ProMem *proMem=0, int DirectFlag=RS_STITCH_LEFT);//,
// proMem的完全封装版本
IplImage* rsStitch(ProParam* proParam,ProMem* proMem);

// rsStitch的辅助函数
// 把Temp的像素覆盖到Res上
int rsCover(IplImage* Res,IplImage* Temp,int x,int y);

// 单位化矩阵 3×3 float
int rsUnitMat(CvMat* M);

// 初始化拼接结果图像
// 把初始图像添加到Res上
IplImage* rsInitRes(ProParam* proParam, IplImage* Image, CvMat* H, int DirectFlag=0);

// 封装到ProMem的单步拼接整合处理函数 主要获得 Hn2r
int rsUpdateStitching(IplImage* Temp,ProMem* proMem,ProParam* proParam);
