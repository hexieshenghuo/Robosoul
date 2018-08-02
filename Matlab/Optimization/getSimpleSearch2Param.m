%% 快速初始化一个Back所需参数
%% 说明
%%
function [BackParam] = getSimpleSearch2Param()
   BackParam.lamda0=5;
   BackParam.Gain=0.2;
   BackParam.K=15;
end