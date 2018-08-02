%% 连杆刚体动力学 作用力矩 Ni 计算函数
%% Ni 是连杆i-1作用连杆i的力 并且是在i下的表示
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% R : 注意 iRi+1 而不是  i+1Ri 
% Nsum
% Nout
% fin
% fout
% Pdown
% Pc
% vargin: Param.R Param.fout Param.Fsum
function [ Nin ] = alNin( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       Nsum=Param.Nsum;
       Nout=Param.Nout;
       fin=Param.fin;
       fout=Param.fout;
       Pdown=Param.Pdown;
       Pc=Param.Pc;
   else
       R=varargin{1};
       Nsum=varargin{2};
       Nout=varargin{3};
       fin=varargin{4};
       fout=varargin{5};
       Pdown=varargin{6};
       Pc=varargin{7};
   end
   Nin= Nsum + R*Nout + Sw(Pc)*fin + Sw(Pdown)*(R*fout);
end