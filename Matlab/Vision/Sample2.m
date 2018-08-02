%% Sample2 仿射Patch集合提取、显示
%% 说明
%%
%% ------参数
   width=25; %patch width
   r=3;       %取Patch比例为了仿射
   M=5;      %需要的点数
%% ------读图
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Wid]=size(G);
%% ------生成点
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=100;       %采样间隔
   Points=getSamplePoints(Range,d); 
   SubPoints=sampleFromPoints(Points,M);
%% ------原始Patch集合生成
   SPSet=getSourcePatchSet(G,Points,width,r);
%% ------生成仿射Patch集合
   %生成仿射矩阵集
   RangeLamda=0.8:0.1:1.2;
   RangeT=0.9:0.1:1.2;
   RangePsi=0:0:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/3:pi/3:pi*2;%0:1:0;%
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵
   %将原始的Patch转为仿射Patch集合
   APSet=getAffinePatchSet(SPSet,TSet,width);%仿射Patch集合   
   
%% ------转换
   p2vParam.width=width;
   p2vParam.Type='r';
   DataVectors=patchSet2Vectors(APSet,p2vParam);
   
   %% 再转换回来
   RecoverPatchSet=dataVectors2PatchSet(DataVectors,width,p2vParam.Type);
   
%% ------显示
   ShowMat= getShowPatchesMat(RecoverPatchSet);
   ShowMat=uint8(ShowMat);
   figure(1);
   imshow(ShowMat);