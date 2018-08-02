%% 自定义一维搜索算法1
%% 说明
% Func:需优化函数的句柄 函数形式必须为： [f,g]=Func(X,FuncParam)
% 其中X为待优化的变量，Data为函数Func的不变参数
% X：见上
% FuncParam：见上
% d：搜索方向
% k:搜索次数
% lamda0：λ的初值
% lamda: 最优步长
% fk:最优的函数值
% gk:当前最优函数梯度
% newX：当前最优解
%% 
function [lamda,newX,fk,gk] = getSimpleSearch1(Func,X,FuncParam,d,Simple1Param,varargin)
%% ------初始化
   K=Simple1Param.K; %最多迭代次数
   lamda0=Simple1Param.lamda0;%λ0
   Step=Simple1Param.Step;
%% ------迭代
   [f,g]=Func(X,FuncParam);
   F=zeros(K,1);
   for k=1:K
       lamda=lamda0+(k-1)*Step;
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam,varargin);
       F(k)=fk;
   end
%% ------取其中最小的
   [F,Indx]=sort(F);
   if F(1)<f
%% 满足下降条件
       lamda=lamda0+(Indx(1)-1)*Step;
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam,varargin);
   else
%% 不满足下降条件 利用Back法
%        BackParam=getBackParam();
%        BackParam.lamda0=lamda0;
%        [lamda,newX,fk,gk] = getBack(Func,X,FuncParam,d,BackParam,varargin);
   end
end

