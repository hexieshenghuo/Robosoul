%% 连杆刚体动力学 作用力 fi 计算函数
%% fi 是连杆i-1作用连杆i的力 并且是在i下的表示
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% R : 注意 iRi+1 而不是  i+1Ri 
% fout
% Fsum
% vargin: Param.R Param.fout Param.Fsum
function [ fin ] = alFin( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       fout=Param.fout;
       Fsum=Param.Fsum;
   else
       R=varargin{1};
       fout=varargin{2};
       Fsum=varargin{3};
   end
   fin= R*fout + Fsum;
end