%% 将网络参数从Param结构中提取出
%% 注意参数的梯度与其有相同维度，如 C 与 df/dC 都是D×H
%% 因此对于梯度的转换也可以用该函数
%%
function [ Alpha,C,S,W,H,D,a] = unpackNetParam( NetParam )
Alpha=NetParam.Alpha;
C=NetParam.C;
S=NetParam.S;
W=NetParam.W;
H=NetParam.H;
D=NetParam.D;%可能用不到
a=NetParam.a;
end