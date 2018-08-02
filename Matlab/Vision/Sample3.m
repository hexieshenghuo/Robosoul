%% Sample3 仿射Patch集合提取、保存与合并
%% 说明
%% 
%% ------参数
   width=19; %patch width
   r=2;       %取Patch比例为了仿射
   M=20;      %需要的点数
%% ------读图
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Wid]=size(G);
%% ------生成点
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=30;       %采样间隔
   Points=getSamplePoints(Range,d); 
   SubPoints1=sampleFromPoints(Points,M);   
   SubPoints2=sampleFromPoints(Points,M);
%% ------原始Patch集合生成
   SPSet1=getSourcePatchSet(G,SubPoints1,width,r);
   SPSet2=getSourcePatchSet(G,SubPoints2,width,r);
%% ------生成仿射Patch集合
   %生成仿射矩阵集
   RangeLamda=1:1:1;%0.9:0.1:1.1;
   RangeT=1:0.1:1;
   RangePsi=0:1:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/3:pi/3:pi*2;%0:1:0;%
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵
   
   %将原始的Patch转为仿射Patch集合
   APSet1=getAffinePatchSet(SPSet1,TSet,width);%仿射Patch集合
   APSet2=getAffinePatchSet(SPSet2,TSet,width);%仿射Patch集合   
   
%% ------转换
   p2vParam.width=width;
   p2vParam.Type='c';
   DataVectors1=patchSet2Vectors(APSet1,p2vParam);
   DataVectors2=patchSet2Vectors(APSet2,p2vParam);
   DataVectors=combineDataVectors(DataVectors1,DataVectors2);
   %% 再转换回来
   RecoverPatchSet=dataVectors2PatchSet(DataVectors,width,p2vParam.Type);
   
%% ------显示
   ShowMat= getShowPatchesMat(RecoverPatchSet);
   ShowMat=uint8(ShowMat);
   figure(1);
   imshow(ShowMat);