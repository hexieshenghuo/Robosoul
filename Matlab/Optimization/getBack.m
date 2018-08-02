%% 后退法一维搜索
%% 说明
% Func:需优化函数的句柄 函数形式必须为： [f,g]=Func(X,FuncParam)
% 其中X为待优化的变量，Data为函数Func的不变参数
% X：见上
% FuncParam：见上
% d：搜索方向
% rho：ρ 准则参数
% K:搜索次数
% gain:增益 资料中的α 避免重复用Gain
% lamda0：λ的初值
% lamda: 最优步长
% fk:最优的函数值
% gk:当前最优函数梯度
% newX：当前最优解
%% 
function [lamda,newX,fk,gk] = getBack(Func,X,FuncParam,d,BackParam,varargin)
%% ------初始化
   % 导入参数
   rho=BackParam.rho; %见函数说明
   K=BackParam.K; %最多迭代次数
   Gain=BackParam.Gain;% α
   lamda=BackParam.lamda0;%λ0
%% ------迭代   
   [f,g]=Func(X,FuncParam);
   Gd=g'*d;% ▽f(x)'d
   fk=0;
   gk=0;
   for k=1:K
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam);%计算 f(x+λd)和 ▽ f(x+λd)
       if fk > f+rho*lamda*Gd % if f(x+λd)≤f(x)+ρλ▽f(x)'d (条件1)
           %更新步长
           lamda=lamda*Gain;
       else
           break;
       end
   end
end