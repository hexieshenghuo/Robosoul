%% BFGS优化算法（单步）
%% 说明
% Func:需优化函数的句柄 函数形式必须为： [f,g]=Func(X,Data)
% X：函数变量，待优化的变量
% 输出X为 当前最优解
% fk：当前最优函数值
% gk：当前最优解梯度
% Data：函数中常量数据，不变参数
% H：BFGS迭代矩阵
% bfgsParam:算法参数

%%
function [newX,H,fk,gk] = BFGS( Func,X, Data, H, bfgsParam,varargin)

%% ------初始化
   dim=length(X);% 向量维数
   SearchParam=bfgsParam.SearchParam;

%% ------判断H是否正定
   res=isPositiveDefinite(H);
   if res==0
       H=eye(dim);
   end
%% ------计算f g
   [f,g]=Func(X,Data);

%% ------计算搜索方向（下降方向）d
   d=-H*g;

%% ------利用一维搜索寻最优步长
   [lamda,newX,fk,gk]=lineSearch(Func,X,FuncParam,d,SearchParam,varargin);

%% ------更新H
   s=newX-X;
   y=gk-g;
   gamma=1/(y'*s);%γ
   I=eye(dim);
   H=(I-gamma*s*y')*H*(I-gamma*y*s')+gamma*s*s';

%% ------测试
   if bfgsParam.Test==1
       Str=sprintf('步长：%f',lamda);
       disp(Str);
   end
end