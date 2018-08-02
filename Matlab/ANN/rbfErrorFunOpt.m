%% 用于优化计算的RBF
%% 说明
% X: RBF参数向量 [C;S;W]
% Data: RBF误差参数,即为输入-输出 [X Yt] 
% Data.rbf
% Data.X
% Data.Yt;
function [ f,g ,varargout] = rbfErrorFunOpt( X ,Data,varargin )
   
   rbf=Data.rbf;
   rbf=rbfUnpack(rbf,X);% X
   
   [f,g]=rbfBatErrorFun(rbf,Data.X,Data.Yt);
end