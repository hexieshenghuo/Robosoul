%% 计算向量W与其他矩阵×乘的矩阵形式
%% 
% W：列向量
function [ S ] = Sw( w )
   S=[0 -w(3) w(2);w(3) 0 -w(1);-w(2) w(1) 0];
end