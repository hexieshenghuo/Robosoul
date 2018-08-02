%% 得到4×4变换矩阵的a向量
%% 说明
% T=[n o a p]; 其次变换矩阵
% a：向量 a
function [ a ] = Va( T )
a=T(1:3,3);
end