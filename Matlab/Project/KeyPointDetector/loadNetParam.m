%% 从文件中读取 NetParam
%%
function [NetParam] = loadNetParam(FileName)
   d=load(FileName);
   NetParam=d.newNetParam;
end