%% 添加DataVectors到一个数据库里
%% 说明：
% Database是一个二维的cell每一个cell是一个DataVectors cell
% Database{d,n} d是DataVectors的向量维数D,n是DataVectors变换数N
%%
function [Database,varargout] = addDataVectors2Database(Database,DataVectors,D,N,varargin)
   srcDataVectors=Database{D,N};
   dstDataVectors=combineDataVectors(srcDataVectors,DataVectors);
   Database{D,N}=dstDataVectors;
end