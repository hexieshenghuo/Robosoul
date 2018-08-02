%% ��һ��ͼ��������һ��DataVectors
%% ˵��
%% 
function [ DataVectors, varargout] = getDataVectors(I,Range,dvParam,varargin)

%% ------��ʼ��   
   width=dvParam.width;
   Type=dvParam.Type;
   r=dvParam.r;
   proParam=dvParam.proParam;
   interval=dvParam.interval;
   RangeLamda=Range{1};
   RangeT=Range{2};
   RangePsi=Range{3};%pi/3:pi/3:pi*2;%
   RangePhi=Range{4};%0:1:0;%
%% ����ͼ��
    if length(size(I))>2
        G=rgb2gray(I);
    else
        G=I;
    end
    [Height,Wid]=size(G);
%% ------���ɵ�
   Margin=ceil(width*r/2);
   PointsRange=[1+Margin Wid-Margin Margin Height-Margin];
   Points=getSamplePoints(PointsRange,interval);
%% ------ԭʼPatch��������
   SPSet=getSourcePatchSet(G,Points,width,r);
%% ------���ɷ���Patch����
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   %��ԭʼ��PatchתΪ����Patch����
   AffinePatchSet=getAffinePatchSet(SPSet,TSet,width);%����Patch����
%% Ԥ����Patch����
   APSet=processPatchSet(AffinePatchSet,proParam);
%% ------ת��
   p2vParam.width=width;
   p2vParam.Type=Type;
   [DataVectors,D]=patchSet2Vectors(APSet,p2vParam);
   
%% 
   varargout{1}=D;
   varargout{2}=AffinePatchSet;
end

