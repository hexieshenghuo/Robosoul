%% �����Ż������RBF
%% ˵��
% X: RBF�������� [C;S;W]
% Data: RBF������,��Ϊ����-��� [X Yt] 
% Data.rbf
% Data.X
% Data.Yt;
function [ f,g ,varargout] = rbfErrorFunOpt( X ,Data,varargin )
   
   rbf=Data.rbf;
   rbf=rbfUnpack(rbf,X);% X
   
   [f,g]=rbfBatErrorFun(rbf,Data.X,Data.Yt);
end