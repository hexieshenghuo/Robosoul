%% 利用Wolfe Powell准则 一维搜索步长lamda λ

%% 参考：

%% 说明
% Func:需优化函数的句柄 函数形式必须为： [f,g]=Func(X,Data)
% 其中X为待优化的变量，Data为函数Func的不变参数
% X：见上
% Data：见上
% d：搜索方向
% rho：ρ 准则参数
% sigma：σ 准测参数
% k:搜索次数
% gain:增益 资料中的α 避免重复用Gain
% lamda0：λ的初值
% lamda: 最优步长
% fk:最优的函数值
% gk:当前最优函数梯度
% newX：当前最优解

%%
function [lamda,newX,fk,gk]=getWolfePowell(Func,X,Data,d,WolfeParam,varargin)

%初始化
   % 导入参数
   rho=WolfeParam.rho; %见函数说明
   sigma=WolfeParam.sigma;%见函数说明
   K=WolfeParam.K; %最多迭代次数
   Method=WolfeParam.Method;
   Gain=WolfeParam.Gain;% α
   lamda0=WolfeParam.lamda0;%λ0
   
   % 运行参数
   a=0;
   M=10000000;
   b=M;
   lamda=lamda0;

   if Method==1 % 第一种方法
       % 计算 f(x)与▽f(x)
       [f,g]=Func(X,Data);
       Gd=g'*d;% ▽f(x)'d
       fk=0;
       gk=0;
       for k=1:K
           [fk,gk]=Func(X+lamda*d,Data);%计算 f(x+λd)和 ▽ f(x+λd)
           if fk <= f+rho*lamda*Gd % if f(x+λd)≤f(x)+ρλ▽f(x)'d (条件1)
               if gk'*d >= sigma*Gd % if ▽f(x+λd)'d≥σ▽f(x)'d  (条件2)
                   break;
               end
               a=lamda;
               % b=b;
               if b==M;
                   lamda=Gain*lamda;
                   continue;
               end
           else %不满足条件1
               % a=a;
               b=lamda;
           end
           lamda=(a+b)/2;
       end
   end
   
   if Method==2 % 第二种方法 没编好
       [f,g]=Func(X,Data);
       for k=1:K
           [fk,gk]=Func(X+lamda*d);      
           if  fk <= f + rho*lamda* g'*d %条件1           
               if gk'*d>=sigma*g'*d      %条件2
                   break;
               else
                   newlamda=lamda+ (lamda-a)*gk'*d /(g'*d-gk'*d);
                   a=lamda;
                   f=fk;
                   g=gk;
                   lamda=newlamda;
               end
           else %不满足条件1
               newlamda=1;
           end
       end
   end
   
   % 顺便更新X
   newX=X+lamda*d;
   if nargin>5
       str=sprintf('步长：%f\n',lamda);
       disp(str);
   end
end