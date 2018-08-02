%% 快速初始化一个WolfePowell所需参数
%% 说明
%%
function [ WolfeParam] = getWolfeParam(varargin)
   WolfeParam.rho=0.1; %见函数说明
   WolfeParam.sigma=0.8;%见函数说明
   WolfeParam.K=10; %最多迭代次数
   WolfeParam.Method=1;
   WolfeParam.Gain=1.2;% α
   WolfeParam.lamda0=1.2;%λ0
   
   if nargin<=1
       return;
   end
   
   N=length(varargin);
   
   for i=1:2:N
       switch varargin{i}
           case 'rho'
               WolfeParam.rho=varargin{i+1};
           case 'sigma'
               WolfeParam.sigma=varargin{i+1};
           case 'K'
               WolfeParam.K=varargin{i+1};
           case 'Method'
               WolfeParam.Method=varargin{i+1};
           case 'Gain'
               WolfeParam.Gain=varargin{i+1};
           case 'lamda0'
               WolfeParam.lamda0=varargin{i+1};
       end         
   end
end