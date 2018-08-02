%% 从一个DataVectors随机选取m列
%% 说明
% varargin{1}是n 若赋值则DataVectors的列数也随机选择
% m:要提取的个数 通常小于M
% DataVectors
%%
function [ SubDataVectors, varargout] = getSubDataVectors(DataVectors,m,varargin)
   [N,M]=size(DataVectors);
   RangeM=getRandomVector([1 M],m);
   RangeN=1:N;
   if nargin>2
       n=varargin{1};
       RangeN=getRandomVector([1 N],n);
   end
   SubDataVectors=DataVectors(RangeN,RangeM);
end

