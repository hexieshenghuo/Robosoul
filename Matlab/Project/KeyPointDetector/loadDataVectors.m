%% 从文件中读取DataVectors
% FileName: .mat文件
%%
function [ DataVectors ] = loadDataVectors(FileName)
   d=load(FileName);
   DataVectors=d.DataVectors;
end