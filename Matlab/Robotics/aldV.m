%% 连杆刚体动力学 角速度 dV 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% R： 
% Wup:    
% dWup:
% dVup:
% Pup:
% vargin: Param.R Param.Wup Param.dWup Param.dVup Param.Pup

function [ dV ] = aldV( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       Wup=Param.Wup;
       dWup=Param.dWup;
       dVup=Param.dVup;
       Pup=Param.Pup;
   else
       R=varargin{1};
       Wup=varargin{2};
       dWup=varargin{3}; 
       dVup=varargin{4};
       Pup=varargin{5};
   end
   dV = R * ( Sw(dWup)*Pup + Sw(Wup)*( Sw(Wup)*Pup ) + dVup);
end