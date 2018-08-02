%% 从一个图像中生成一个DataVectors
%% 说明
%% 
function [ DataVectors, varargout] = getDataVectors(I,Range,dvParam,varargin)

%% ------初始化   
   width=dvParam.width;
   Type=dvParam.Type;
   r=dvParam.r;
   proParam=dvParam.proParam;
   interval=dvParam.interval;
   RangeLamda=Range{1};
   RangeT=Range{2};
   RangePsi=Range{3};%pi/3:pi/3:pi*2;%
   RangePhi=Range{4};%0:1:0;%
%% 处理图像
    if length(size(I))>2
        G=rgb2gray(I);
    else
        G=I;
    end
    [Height,Wid]=size(G);
%% ------生成点
   Margin=ceil(width*r/2);
   PointsRange=[1+Margin Wid-Margin Margin Height-Margin];
   Points=getSamplePoints(PointsRange,interval);
%% ------原始Patch集合生成
   SPSet=getSourcePatchSet(G,Points,width,r);
%% ------生成仿射Patch集合
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵
   %将原始的Patch转为仿射Patch集合
   AffinePatchSet=getAffinePatchSet(SPSet,TSet,width);%仿射Patch集合
%% 预处理Patch集合
   APSet=processPatchSet(AffinePatchSet,proParam);
%% ------转换
   p2vParam.width=width;
   p2vParam.Type=Type;
   [DataVectors,D]=patchSet2Vectors(APSet,p2vParam);
   
%% 
   varargout{1}=D;
   varargout{2}=AffinePatchSet;
end

