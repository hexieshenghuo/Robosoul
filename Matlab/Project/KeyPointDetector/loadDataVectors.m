%% ���ļ��ж�ȡDataVectors
% FileName: .mat�ļ�
%%
function [ DataVectors ] = loadDataVectors(FileName)
   d=load(FileName);
   DataVectors=d.DataVectors;
end