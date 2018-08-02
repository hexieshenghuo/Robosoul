%% 根据3×3旋转矩阵R 与 3×1 向量矩阵 P组合为4×4其次矩阵T
function [ T ] = MT( R,P )
   T=[R P;0 0 0 1];
end