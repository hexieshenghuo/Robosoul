%% �洢�������
% ���������������в���
%%
function [ newNetParam ]= saveNetParam(NetParam,FileName,width,Type,DetectMethod,ProMethod)
   newNetParam=NetParam;
   newNetParam.width=width;
   newNetParam.Type=Type;
   newNetParam.DetectMethod=DetectMethod;
   newNetParam.ProMethod=ProMethod;
   save(FileName,'newNetParam');
end

