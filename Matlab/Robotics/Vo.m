%% 得到4×4变换矩阵的o向量
%% 说明
% T=[n o a p]; 其次变换矩阵
% o：向量 o
function [ o ] = Vo( T )
o=T(1:3,2);
end