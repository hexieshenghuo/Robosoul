%% 存储网络参数
% 包括运行所需所有参数
%%
function [ newNetParam ]= saveNetParam(NetParam,FileName,width,Type,DetectMethod,ProMethod)
   newNetParam=NetParam;
   newNetParam.width=width;
   newNetParam.Type=Type;
   newNetParam.DetectMethod=DetectMethod;
   newNetParam.ProMethod=ProMethod;
   save(FileName,'newNetParam');
end

