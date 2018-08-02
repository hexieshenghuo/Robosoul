%% 计算NetParam所有参数的总维度
function [ Dim ] = getParamDim(D,H)
   Dim=D*H*2+2*H;
end