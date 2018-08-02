%% 从数据库里获取当前模型训练所需的DataVectors
%% 说明：
% D: DataVectors中每个向量的维数
% N: 变换的次数
%%
function [ DataVectors,varargout ] = getDataVectorsFromDatabase(Database,D,N,varargin)
   DataVectors=Database{D,N};
end