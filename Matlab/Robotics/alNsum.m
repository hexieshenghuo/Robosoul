%% 连杆刚体动力学 合力 F 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% dW
% W
% Ic
% vargin: Param.dW Param.W Param.Ic
function [ Nsum ] = alNsum( varargin )
   if(nargin==1)
       Param=varargin{1};
       dW=Param.dW;
       W=Param.W;
       Ic=Param.Ic;
   else
       dW=varargin{1};
       W=varargin{2};
       Ic=varargin{3};
   end
   N=Ic*dW + Sw(W)*(Ic*W);
end

