%% ���ٳ�ʼ��һ��WolfePowell�������
%% ˵��
%%
function [ WolfeParam] = getWolfeParam(varargin)
   WolfeParam.rho=0.1; %������˵��
   WolfeParam.sigma=0.8;%������˵��
   WolfeParam.K=10; %����������
   WolfeParam.Method=1;
   WolfeParam.Gain=1.2;% ��
   WolfeParam.lamda0=1.2;%��0
   
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