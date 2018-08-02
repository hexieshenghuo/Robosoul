%% 将向量X转为点矩阵
%% 说明
function [ Points] = vector2Points(X,Dim,N)
   Points=reshape(X,Dim,N);
end