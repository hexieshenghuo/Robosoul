%% 随机搜索步长
%% 说明 不需要计算梯度
%%
function [lamda,newX,fk,gk] = getRandom(Func,X,FuncParam,d,RandomParam,varargin)
%% ------初始化   
   MaxRange=RandomParam.MaxRange;
   K=RandomParam.K;
   lamda0=RandomParam.lamda0;
   FuncParam.IsGradient=0;
   [f,g]=Func(X,FuncParam,varargin);
%% ------搜索步长
   lamda=0;
   newX=X;
   fk=0;
   gk=0;
   for k=1:K
       lamda=rand(1)*MaxRange;
       newX=X + lamda*d;
       [fk,gk]=Func(newX,FuncParam,varargin);
       if f>fk
           FuncParam.IsGradient=1;
           [fk,gk]=Func(newX,FuncParam,varargin);
           return;
       end
   end
   lamda=lamda0;
   FuncParam.IsGradient=1;
   [fk,gk]=Func(newX,FuncParam,varargin);
end

