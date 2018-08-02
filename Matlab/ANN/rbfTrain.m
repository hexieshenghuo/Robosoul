%% 单步训练一次rbf神经网络
%% 说明
% optX 需要优化的X,即[C;S;W]
% FuncParam: 目标函数所需参数
function [ rbf ,varargout] = rbfTrain( rbf,X,Yt,varargin)

   if nargin<4
       % 默认训练方式
       FuncParam.X=X;
       FuncParam.Yt=Yt;
       FuncParam.rbf=rbf;
       optX=rbfPackParam(rbf);
       SearchParam=getBackParam();
       SearchParam.lamda=6.6e-06;
       SearchParam.Method='Const';
       GDParam.SearchParam=SearchParam;
       
       [newX,f,g] = GD(@rbfErrorFunOpt,optX,FuncParam,GDParam);
%        disp(g);
       rbf=rbfUnpack(rbf,newX);
       
       if nargout>1
           varargout{1}=f;
       end
       
   else
       % 根据参数训练
       
   end
   
end