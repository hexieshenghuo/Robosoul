%% 计算旋转矩阵 3×3
% theta:旋转的角度 弧度制
% M:结果矩阵

%%
function  M  = Rot( theta )
s=sin(theta);
c=cos(theta);
M=[c -s 0;s c 0;0 0 1];
end

