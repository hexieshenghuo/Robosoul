%% ���ļ��ж�ȡ NetParam
%%
function [NetParam] = loadNetParam(FileName)
   d=load(FileName);
   NetParam=d.newNetParam;
end