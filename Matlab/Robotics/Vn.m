%% 得到4×4变换矩阵的n向量
%% 说明
% T=[n o a p]; 其次变换矩阵
% n：向量 n
function [ n ] = Vn( T )
n=T(1:3,1);
end

