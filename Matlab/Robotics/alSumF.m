%% 连杆刚体动力学 合力 F 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% dVc
% m
% vargin: Param.dVc Param.m
function [ Fsum ] = alSumF( varargin )
   if(nargin==1)
       Param=varargin{1};
       dVc=Param.dVc;
       m=Param.m;
   else
       dVc=varargin{1};
       m=varargin{2};
   end
   Fsum=m*dVc;
   
end

