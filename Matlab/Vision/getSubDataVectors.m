%% ��һ��DataVectors���ѡȡm��
%% ˵��
% varargin{1}��n ����ֵ��DataVectors������Ҳ���ѡ��
% m:Ҫ��ȡ�ĸ��� ͨ��С��M
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

