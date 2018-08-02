%% 连杆刚体动力学 角速度 dVc 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% W:    
% dW:
% dV:
% Pup
% Pc:
% vargin: Param.Wup Param.dW Param.dV Param.Pup Param.Pc

function [ dVc ] = aldVc( varargin )
   if(nargin==1)
       Param=varargin{1};
       W=Param.W;
       dW=Param.dW;
       dV=Param.dV;
       Pup=Param.Pup;
       Pc=Param.Pc;
   else
       W=varargin{1};
       dW=varargin{2};
       dV=varargin{3}; 
       Pup=varargin{4};
       Pc=varargin{5};
   end
   dVc = Sw(dW)*Pc + Sw(W)*(Sw(W)*Pup) + dV;
end