%% 得到4×4变换矩阵的p向量
%% 说明
% T=[n o a p]; 4×4 其次变换矩阵
% p：3×1向量p
function [ p ] = Vp( T )
p=T(1:3,4);
end