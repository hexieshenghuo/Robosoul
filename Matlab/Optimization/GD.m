%% 单步梯度下降算法
%% 说明 
% lamda: 步长

function [newX,fk,gk,varargout] = GD(Func,X,FuncParam,GDParam,varargin)
%% ------初始化
   SearchParam=GDParam.SearchParam;
%% ------提取梯度和下降方向
   [f,g]=Func(X,FuncParam,varargin);
   d=-g; %下降方向
%% ----一维搜索并更新   
   [lamda,newX,fk,gk]=lineSearch(Func,X,FuncParam,d,SearchParam,varargin);
%% 测试
   if nargin>4
       varargout{1}=lamda;
   end
end