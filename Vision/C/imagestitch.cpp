#include "imagestitch.h"

int rsCorners(IplImage* img, CvPoint2D32f* Points, CvArr* Mask, IplImage* Temp1, IplImage* Temp2, ProParam* proparam)
{
    int CornerCount=0;
    cvGoodFeaturesToTrack(img,Temp1,Temp2,
                          Points,&CornerCount,proparam->QualityLevel,
                          proparam->MinDis,Mask,proparam->BlockSize,proparam->UseHarris,proparam->K);
    return CornerCount;
}

int rsCorners(IplImage* img, CvPoint2D32f* Points,ProMem* proMem,ProParam* proparam)
{
    return rsCorners(img,Points,proMem->Mask,proMem->Temp1,proMem->Temp2,proparam);
}

int rsPointTrans(CvPoint2D32f *Psrc, CvPoint2D32f* Pdst, CvMat* H)
{
    float x=0,y=0,w=0;

    x=rsMat32F(H,0,0)*Psrc->x + rsMat32F(H,0,1)*Psrc->y + rsMat32F(H,0,2);
    y=rsMat32F(H,1,0)*Psrc->x + rsMat32F(H,1,1)*Psrc->y + rsMat32F(H,1,2);
    w=rsMat32F(H,2,0)*Psrc->x + rsMat32F(H,2,1)*Psrc->y + rsMat32F(H,2,2);

    Pdst->x=x/w;
    Pdst->y=y/w;

    return 0;
}

int rsPsTrans(CvPoint2D32f* Psrc,CvPoint2D32f* Pdst,int Num,CvMat* H)
{
    for (int i=0;i<Num;i++)
    {
        rsPointTrans(&Psrc[i],&Pdst[i],H);
    }
    return 0;
}


int rsSubPixel(IplImage* img,CvPoint2D32f* Corners,int CornerNum,ProParam* proParam)
{
    cvFindCornerSubPix(img,Corners,CornerNum,cvSize(proParam->SubSize,proParam->SubSize),cvSize(-1,-1),proParam->SubTerm);
    return 0;
}

int rsLoadProParam(const char* FileName, ProParam* proparam, CvSize *ImageSize)
{
    if(ImageSize)
    {
        proparam->ImageSize.width=ImageSize->width;
        proparam->ImageSize.height=ImageSize->height;
    }

    vector<string> Strs;
    rsGetStringVector(Strs,FileName);

    sscanf(Strs[0].c_str(),"QualityLevel : %lf",&proparam->QualityLevel);
    sscanf(Strs[1].c_str(),"MinDis : %lf",&proparam->MinDis);
    sscanf(Strs[2].c_str(),"BlockSize : %d",&proparam->BlockSize);
    sscanf(Strs[3].c_str(),"K : %lf",&proparam->K);
    sscanf(Strs[4].c_str(),"UseHarris : %d",&proparam->UseHarris);
    sscanf(Strs[5].c_str(),"HarrisROI : x %d, y %d, width %d, height %d"
                          ,&proparam->HarrisROI.x,&proparam->HarrisROI.y
                          ,&proparam->HarrisROI.width,&proparam->HarrisROI.height);
    sscanf(Strs[6].c_str(),"PointMaxNum : %d",&proparam->PointMaxNum);
    sscanf(Strs[7].c_str(),"SubTerm : type : %d, max_iter : %d,  epsilon : %lf",
                           &proparam->SubTerm.type,&proparam->SubTerm.max_iter,&proparam->SubTerm.epsilon);
    sscanf(Strs[8].c_str(),"SubSize : %d",&proparam->SubSize);
    sscanf(Strs[9].c_str(),"LKSize : %d",&proparam->LKSize);
    sscanf(Strs[10].c_str(),"LKLevel : %d",&proparam->LKLevel);
    sscanf(Strs[11].c_str(),"LKTerm : type : %d, max_iter : %d,  epsilon : %lf",
                            &proparam->LKTerm.type,&proparam->LKTerm.max_iter,&proparam->LKTerm.epsilon);
    sscanf(Strs[12].c_str(),"LKFlag    : %d",&proparam->LKFlag);
    sscanf(Strs[13].c_str(),"HomoMethod :  %d",&proparam->HomoMethod);
    sscanf(Strs[14].c_str(),"ransacThres : %lf",&proparam->ransacThres);

    sscanf(Strs[15].c_str(),"ResSize : width %d, height %d",&proparam->ResSize.width,&proparam->ResSize.height);
    sscanf(Strs[16].c_str(),"StitchROI : x %d, y %d, width %d, height %d",&proparam->StitchROI.x,&proparam->StitchROI.y,&proparam->StitchROI.width,&proparam->StitchROI.height);

    sscanf(Strs[17].c_str(),"VertShortStep : %d",&proparam->VertShortStep);
    sscanf(Strs[18].c_str(),"VertLongStep : %d",&proparam->VertLongStep);
    sscanf(Strs[19].c_str(),"VertWidth : %d",&proparam->VertWidth);
    sscanf(Strs[20].c_str(),"VertHeight : %d",&proparam->VertHeight);
    sscanf(Strs[21].c_str(),"VertRect  :  x %d,  y  %d,  width %d,  height %d",
                                          &proparam->VertRect.x,&proparam->VertRect.y,&proparam->VertRect.width,&proparam->VertRect.height);

    sscanf(Strs[22].c_str(),"VertThres : %lf",&proparam->VertThres );
    sscanf(Strs[23].c_str(),"xOrder   : %d",&proparam->xOrder );
    sscanf(Strs[24].c_str(),"VertLsdScale   : %lf",&proparam->VertLsdScale);
    sscanf(Strs[25].c_str(),"VertLsdGain   : %lf",&proparam->VertLsdGain);
    sscanf(Strs[26].c_str(),"VertMethod   : %d",&proparam->VertMethod);

    sscanf(Strs[27].c_str(),"HorShortStep : %d",&proparam->HorShortStep);
    sscanf(Strs[28].c_str(),"HorLongStep : %d",&proparam->HorLongStep);
    sscanf(Strs[29].c_str(),"HorWidth :   %d",&proparam->HorWidth);
    sscanf(Strs[30].c_str(),"HorHeight :  %d",&proparam->HorHeight);
    sscanf(Strs[31].c_str(),"HorRect  :  x  %d,  y  %d,  width  %d,  height  %d",
                                          &proparam->HorRect.x,&proparam->HorRect.y,&proparam->HorRect.width,&proparam->HorRect.height);

    sscanf(Strs[32].c_str(),"HorThres :  %lf",&proparam->HorThres );
    sscanf(Strs[33].c_str(),"yOrder   :  %d",&proparam->yOrder );
    sscanf(Strs[34].c_str(),"HorLsdScale   :  %lf",&proparam->HorLsdScale);
    sscanf(Strs[35].c_str(),"HorLsdGain   :  %lf",&proparam->HorLsdGain);
    sscanf(Strs[36].c_str(),"HorMethod   :  %d",&proparam->HorMethod);

    //热斑
    sscanf(Strs[37].c_str(),"SpotRect    : x %d,    y  %d,  width %d,  height %d",
            &proparam->SpotRect.x,&proparam->SpotRect.y,&proparam->SpotRect.width,&proparam->SpotRect.height);
    sscanf(Strs[38].c_str(),"HeatConfig : threshold %d, EDnum  %d",
                            &proparam->HeatConfig.threshold,&proparam->HeatConfig.EDnum);


    proparam->OffsetY=(float)(proparam->ResSize.height - proparam->ImageSize.height)/2;
    return 0;
}

int rsInitProMem(ProParam* proParam,ProMem* proMem)
{
    proMem->Mask=0;
    proMem->Temp1=0;
    proMem->Temp2=0;
    proMem->Status=new char[proParam->PointMaxNum];
    memset(proMem->Status,0,sizeof(char)*proParam->PointMaxNum);

    proMem->PrevPyramid=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,1);
    cvZero(proMem->PrevPyramid);
    proMem->CurrPyramid=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,1);
    cvZero(proMem->CurrPyramid);

    proMem->StitchTemp=cvCreateImage(proParam->ResSize,IPL_DEPTH_8U,3);
    cvZero(proMem->StitchTemp);

    proMem->StitchPre=cvCreateImage(cvSize(proParam->StitchROI.width,proParam->StitchROI.height),IPL_DEPTH_8U,3);
    proMem->StitchCurr=cvCreateImage(cvSize(proParam->StitchROI.width,proParam->StitchROI.height),IPL_DEPTH_8U,3);

    //初始化角点提取区域的Mask
    proMem->Mask=rsGetMaskFromROI(proParam->ImageSize,proParam->HarrisROI);

    // 变换矩阵
    proMem->Ho2r=0;
    proMem->Hn2o=0;
    proMem->Hn2r=0;

    proMem->Ho2r=cvCreateMat(3,3,CV_32FC1);// old to Res
    proMem->Hn2o=cvCreateMat(3,3,CV_32FC1);// new to old
    proMem->Hn2r=cvCreateMat(3,3,CV_32FC1);// new to Res

    rsUnitMat(proMem->Ho2r);
    rsUnitMat(proMem->Hn2o);
    rsUnitMat(proMem->Hn2r);

    proMem->Ps1=new CvPoint2D32f[proParam->PointMaxNum];
    proMem->Ps2=new CvPoint2D32f[proParam->PointMaxNum];
    proMem->Ps3=new CvPoint2D32f[proParam->PointMaxNum];

    proMem->PreImage=0;
    proMem->CurrImage=0;

    proMem->grayPre =0;
    proMem->grayCurr = 0;

    proMem->PreImage=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,3);
    proMem->CurrImage=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,3);

    proMem->grayPre = cvCreateImage(proParam->ImageSize, IPL_DEPTH_8U,1);
    proMem->grayCurr = cvCreateImage(proParam->ImageSize, IPL_DEPTH_8U,1);

    proMem->Res=0;

    proMem->DirectFlag=0;

    proMem->LineImage=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,3);
    proMem->LineGray=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,1);
    proMem->LineImage64=cvCreateImage(proParam->ImageSize,IPL_DEPTH_64F,1);
    proMem->LineSum64=cvCreateImage(proParam->ImageSize,IPL_DEPTH_64F,1);
    proMem->LineSum=cvCreateImage(proParam->ImageSize,IPL_DEPTH_8U,3);

    proMem->Lines=new CvPoint2D64d[1000];

    return 0;
}

int rsReleaseProMem(ProMem **promem)
{
    ProMem* proMem=promem[0];

    if(!proMem)
    {
        return 0;
    }

    if(proMem->Mask)
    {
//        cvReleaseImage(&proMem->Mask);
        cvReleaseMat(&proMem->Mask);
        proMem->Mask=0;
    }
    if(proMem->Temp1)
    {
        cvReleaseImage(&proMem->Temp1);
        proMem->Temp1=0;
    }
    if(proMem->Temp2)
    {
        cvReleaseImage(&proMem->Temp2);
        proMem->Temp2=0;
    }

    if(proMem->Status)
    {
        delete[] proMem->Status;
        proMem->Status=0;
    }

    if(proMem->PrevPyramid)
    {
        cvReleaseImage(&proMem->PrevPyramid);
        proMem->PrevPyramid=0;
    }

    if(proMem->CurrPyramid)
    {
        cvReleaseImage(&proMem->CurrPyramid);
        proMem->CurrPyramid=0;
    }

    if(proMem->StitchTemp)
    {
        cvReleaseImage(&proMem->StitchTemp);
        proMem->StitchTemp=0;
    }

    if(proMem->StitchPre)
    {
        cvReleaseImage(&proMem->StitchPre);
        proMem->StitchPre=0;
    }

    if(proMem->StitchCurr)
    {
        cvReleaseImage(&proMem->StitchCurr);
        proMem->StitchCurr=0;
    }

    if(proMem->Hn2o)
    {
        cvReleaseMat(&proMem->Hn2o);
        proMem->Hn2o=0;
    }

    if(proMem->Hn2r)
    {
        cvReleaseMat(&proMem->Hn2r);
        proMem->Hn2r=0;
    }

    if(proMem->Ho2r)
    {
        cvReleaseMat(&proMem->Ho2r);
        proMem->Ho2r=0;
    }

    if(proMem->Ps1)
    {
        delete [] proMem->Ps1;
        proMem->Ps1=0;
    }

    if(proMem->Ps2)
    {
        delete [] proMem->Ps1;
        proMem->Ps2=0;
    }

    if(proMem->Ps3)
    {
        delete [] proMem->Ps1;
        proMem->Ps3=0;
    }

    if(proMem->PreImage)
    {
        cvReleaseImage(&proMem->PreImage);
        proMem->PreImage=0;
    }

    if(proMem->CurrImage)
    {
        cvReleaseImage(&proMem->CurrImage);
        proMem->CurrImage=0;
    }

    if(proMem->grayPre)
    {
        cvReleaseImage(&proMem->grayPre);
        proMem->grayPre=0;
    }

    if(proMem->grayCurr)
    {
        cvReleaseImage(&proMem->grayCurr);
        proMem->grayCurr=0;
    }

    if(proMem->Res)
    {
        cvReleaseImage(&proMem->Res);
        proMem->Res=0;
    }

    if(proMem->LineImage)
    {
        cvReleaseImage(&proMem->LineImage);
        proMem->LineImage=0;
    }

    if(proMem->LineImage64)
    {
        cvReleaseImage(&proMem->LineImage64);
        proMem->LineImage64=0;
    }

    if(proMem->LineGray)
    {
        cvReleaseImage(&proMem->LineGray);
        proMem->LineGray=0;
    }

    if(proMem->LineSum)
    {
        cvReleaseImage(&proMem->LineSum);
        proMem->LineSum=0;
    }

    if(proMem->LineSum64)
    {
        cvReleaseImage(&proMem->LineSum64);
        proMem->LineSum64=0;
    }

    if(proMem->Lines)
    {
        delete[] proMem->Lines;
        proMem->Lines=0;
    }

    if(proMem)
    {
        delete proMem;
        proMem=0;
    }

    return 0;
}

int rsLK(IplImage* PrevImage, IplImage* CurrImage, CvPoint2D32f* PrePoints, CvPoint2D32f* CurrPoints, int PointNum, ProMem* proMem, ProParam* proParam)
{
    cvCalcOpticalFlowPyrLK(PrevImage,CurrImage,proMem->PrevPyramid,proMem->CurrPyramid,
                           PrePoints,CurrPoints,PointNum,cvSize(proParam->LKSize,proParam->LKSize),
                           proParam->LKLevel,proMem->Status,0,proParam->LKTerm,proParam->LKFlag);
    return 0;
}

int rsDisplayPoints(CvPoint2D32f* P1,CvPoint2D32f* P2,int PointsNum,int Type)
{
    if(Type==0)
    {
        for(int i=0;i<PointsNum;i++)
        {
            cout<<"P1.x: "<<P1[i].x<<", "<<"P1.y: "<<P1[i].y<<", ";
            cout<<"P2.x: "<<P2[i].x<<", "<<"P2.y: "<<P2[i].y<<endl;
        }
    }
    else
    {
        for(int i=0;i<PointsNum;i++)
        {
            cout<<"offset x: "<<P2[i].x-P1[i].x<<", "<<"offset y: "<<P2[i].y-P1[i].y<<endl;
        }
    }
    return 0;
}

int rsDisplayH(CvMat* H)
{
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<3;j++)
        {
            cout<<rsMat32F(H,i,j)<<" ";
        }
        cout<<endl;
    }
    return 0;
}

int rsSimpleH(CvMat* H)
{

    rsMat32F(H,0,0)=1; rsMat32F(H,0,1)=0;
    rsMat32F(H,1,0)=0; rsMat32F(H,1,1)=1;
    rsMat32F(H,2,0)=0; rsMat32F(H,2,1)=0;
    rsMat32F(H,2,2)=1;

    return 0;
}

int rsGetH(CvPoint2D32f* Psrc, CvPoint2D32f* Pdst,int PointsNum,CvMat* H, ProParam* proParam)
{
    CvMat* PsrcMat=cvCreateMat(PointsNum,2,CV_32FC1);
    CvMat* PdstMat=cvCreateMat(PointsNum,2,CV_32FC1);

    cvSetData(PsrcMat,Psrc,sizeof(CvPoint2D32f));
    cvSetData(PdstMat,Pdst,sizeof(CvPoint2D32f));

    cvFindHomography(PsrcMat,PdstMat,H,proParam->HomoMethod,proParam->ransacThres,0);

    if(PsrcMat)
    {
        cvReleaseMat(&PsrcMat);
        PsrcMat=0;
    }

    if(PdstMat)
    {
        cvReleaseMat(&PdstMat);
        PdstMat=0;
    }
    return 0;
}

int rsCover(IplImage* Res,IplImage* Temp,int x,int y)
{
    uchar B=rsImage8U3(Temp,x,y,0);
    uchar G=rsImage8U3(Temp,x,y,1);
    uchar R=rsImage8U3(Temp,x,y,2);

    if( R || G || R )
    {
        rsImage8U3(Res,x,y,0)=B;
        rsImage8U3(Res,x,y,1)=G;
        rsImage8U3(Res,x,y,2)=R;
    }

    return 0;
}

IplImage* rsStitch(ProParam* proParam,ProMem* proMem)
{
    return rsStitch(proMem->Res,proMem->PreImage,proMem->Ho2r,proMem->Res,proParam,proMem,proMem->DirectFlag);
}

IplImage* rsStitch(IplImage* Base, IplImage* ImageStitched, CvMat* H, IplImage* Res,ProParam* proParam,ProMem* proMem,int DirectFlag)
{
#define  method 2
#if (method==0)
    /*
    CvSize resSize=cvSize(800,500);
    if(proParam)
    {
        resSize=proParam->ResSize;
    }

    if( Base==Res || !Res)
    {
        Res=cvCreateImage(resSize,IPL_DEPTH_8U,3);
    }

    float offsetYBase=(float)(resSize.height-Base->height)/2;
    float offsetYS=(float)(resSize.height-ImageStitched->height)/2;

    //ImageStitched
    rsMat32F(H,1,2)=rsMat32F(H,1,2)+offsetYS;
    cvZero(Res);
    cvWarpPerspective(ImageStitched,Res,H);
    rsMat32F(H,1,2)=rsMat32F(H,1,2)-offsetYS;

    //Base
    cvSetImageROI(Res,cvRect(0,(int)offsetYBase,Base->width,Base->height));
    cvZero(Res);
    cvAdd(Base,Res,Res);
    cvResetImageROI(Res);

    if(Base==Res)
    {
        cvReleaseImage(&Base);
        Base=0;
    }

#elif(method==1)
    CvSize resSize=cvSize(800,500);
    if(proParam)
    {
        resSize=proParam->ResSize;
    }
    IplImage* Temp=0;
    if(proMem)
    {
        Temp=proMem->StitchTemp;
    }
    else
    {
        Temp=cvCreateImage(resSize,IPL_DEPTH_8U,3);
    }

    if( Base!=Res && Res )//指针不同并且Res不为空
    {
        cvCopyImage(Base,Res);
    }

    float offsetYBase=(float)(resSize.height-Base->height)/2;
    float offsetYS=(float)(resSize.height-ImageStitched->height)/2;

    //ImageStitched
    rsMat32F(H,1,2)=rsMat32F(H,1,2)+offsetYS;
    cvZero(Temp);
    cvWarpPerspective(ImageStitched,Temp,H);
    rsMat32F(H,1,2)=rsMat32F(H,1,2)-offsetYS;

    //Res Temp 覆盖 Res
    for(int x=0;x<Res->width;x++)
    {
        for(int y=0;y<Res->height;y++)
        {
            rsCover(Res,Temp,x,y);
        }
    }
//    cvCopyImage(Temp,Res);

    // 内存管理

    if(!proMem)
    {
        cvReleaseImage(&Temp);
        Temp=0;
    }
    */
#elif(method==2)

    //默认Size
    CvSize resSize=cvSize(800,500);

    //导入实际Size
    if(proParam)
    {
        resSize=proParam->ResSize;
    }
    IplImage* Temp=0;
    if(proMem)
    {
        Temp=proMem->StitchTemp;
    }
    else
    {
        Temp=cvCreateImage(resSize,IPL_DEPTH_8U,3);
    }

    if( Base!=Res && Res )//指针不同并且Res不为空
    {
        cvCopyImage(Base,Res);
    }

    float offsetYBase=(float)(resSize.height-Base->height)/2;


    //ImageStitched
    rsMat32F(H,1,2)=rsMat32F(H,1,2)+proParam->OffsetY; //{{{偏移
    cvZero(Temp);

    //透视变换
    cvWarpPerspective(ImageStitched,Temp,H);
    rsMat32F(H,1,2)=rsMat32F(H,1,2)-proParam->OffsetY;// 还原}}}

    //计算边界
    CvPoint2D32f srcP[2];
    CvPoint2D32f dstP[2];

    if(!DirectFlag)
    {
        srcP[0] = cvPoint2D32f(0,0);
        srcP[1] = cvPoint2D32f(0,ImageStitched->height);

        rsPsTrans(srcP,dstP,2,H);
        int Overmeasure=2; //裕量
        int MarginX=MAX(0,MIN(dstP[0].x,dstP[1].x))+ Overmeasure;

        //Res
        cvSetImageROI(Temp,cvRect(0,0,MarginX,Temp->height));
        cvSetImageROI(Res,cvRect(0,0,MarginX,Temp->height));

        cvCopyImage(Res,Temp);

        cvResetImageROI(Res);
        cvResetImageROI(Temp);

        cvCopyImage(Temp,Res);

    }
    else
    {
        srcP[0] = cvPoint2D32f(ImageStitched->width-1,0);
        srcP[1] = cvPoint2D32f(ImageStitched->width-1,ImageStitched->height-1);
        rsPsTrans(srcP,dstP,2,H);

        int Overmeasure=2; //裕量
        int MarginX= MIN(ImageStitched->width, MAX(dstP[0].x,dstP[1].x))-Overmeasure;

        //Res
        cvSetImageROI(Temp,cvRect(MarginX,0,Temp->width-MarginX,Temp->height));
        cvSetImageROI(Res,cvRect(MarginX,0,Temp->width-MarginX,Temp->height));

        cvCopyImage(Res,Temp);

        cvResetImageROI(Res);
        cvResetImageROI(Temp);

        cvCopyImage(Temp,Res);
    }

    // 内存管理
    if(!proMem)
    {
        cvReleaseImage(&Temp);
        Temp=0;
    }

#endif
    return Res;
}

int rsUnitMat(CvMat* M)
{
    cvZero(M);
    rsMat32F(M,0,0)=1;
    rsMat32F(M,1,1)=1;
    rsMat32F(M,2,2)=1;

    return 0;
}

IplImage* rsInitRes(ProParam* proParam,IplImage* Image,CvMat* H,int DirectFlag)
{
    IplImage* Res=cvCreateImage(proParam->ResSize,IPL_DEPTH_8U,3);
    cvZero(Res);

    if(H)
    {
        rsUnitMat(H);
    }

    // 从左向右
    float offsetX=0;

    // 从右向左
    if(DirectFlag)
    {
        offsetX=proParam->ResSize.width-Image->width;
        rsMat32F(H,0,2)=offsetX;
    }

    if(Image)
    {
        float offsetY=(float)(proParam->ResSize.height-Image->height)/2;
        cvSetImageROI(Res,cvRect(offsetX,(int)offsetY,Image->width,Image->height));
        cvAdd(Image,Res,Res);
        cvResetImageROI(Res);
    }

    return Res;
}


int rsUpdateStitching(IplImage* Temp,ProMem* proMem,ProParam* proParam)
{
    cvCopyImage(Temp,proMem->CurrImage);
    cvCvtColor(proMem->CurrImage, proMem->grayCurr, CV_BGR2GRAY);

    // Corner
    int PointsNum=rsCorners(proMem->grayPre,proMem->Ps1,proMem,proParam);
    rsSubPixel(proMem->grayPre,proMem->Ps1,PointsNum,proParam);

    if(PointsNum==0)
    {
        return 0;
    }

    // L-K
    rsLK(proMem->grayPre,proMem->grayCurr,proMem->Ps1,proMem->Ps2,PointsNum,proMem,proParam);
    rsSubPixel(proMem->grayCurr,proMem->Ps2,PointsNum,proParam);

    // Homography
    rsPsTrans(proMem->Ps1,proMem->Ps3,PointsNum,proMem->Ho2r);
    rsGetH(proMem->Ps2,proMem->Ps3,PointsNum,proMem->Hn2r,proParam);

    // 化简
    rsSimpleH(proMem->Hn2r);

    //拼接
    proMem->Res=rsStitch(proMem->Res,proMem->CurrImage,proMem->Hn2r,proMem->Res,proParam,proMem,proMem->DirectFlag);

    // Upate
    CvMat* tempH=0;
    IplImage* TempImage=0;

    CV_SWAP(proMem->Hn2r,proMem->Ho2r,tempH);
    CV_SWAP(proMem->grayCurr,proMem->grayPre,TempImage);

    return PointsNum;
}
