%% 将Param中需要训练的变量写成向量形式 顺序为：Alpha C S W
%% 说明 其中
% Alpha：D×H
% C：D×H
% S：H×1
% W：H×1
% D：输入的维数
% H：隐层节点个数
% Vector：2（D+1）H×1维向量
%% 注意参数的梯度与其有相同维度，如 C 与 df/dC 都是D×H
%% 因此对于梯度的转换也可以用该函数
%%
function [Vector] = netParam2Vector(NetParam)
% 转换！
Alpha=NetParam.Alpha;
C=NetParam.C;
S=NetParam.S;
W=NetParam.W;
D=NetParam.D;
H=NetParam.H;

% Alpha
vectorAlpha=reshape(Alpha,D*H,1);
% C
vectorC=reshape(C,D*H,1);
% S
   %无需
% W
   %无需
%存储
Vector=[vectorAlpha;vectorC;S;W];
end

