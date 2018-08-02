%% 得到制定文件夹下所有制定类型文件
%% 说明
% Dir：文件夹路径
% Postfix：文件后缀
% 用法如： FileName=getFileNames('G:/RoboSoul/Vision/Matlab','m');
% 或  FileName=getFileNames('../../Vision/Matlab','m');
%%
function [ FileNames ] = getFileNames(Dir,Postfix)
   dirOutput=dir([Dir '/*.' Postfix]);
   FileNames={dirOutput.name}';% 这个语法很有用
end