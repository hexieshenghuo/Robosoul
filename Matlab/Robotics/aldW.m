%% 连杆刚体动力学 角速度 dω 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% R： 
% Wup:    
% dWup:
% dTheta:
% ddTheta:
% vargin: Param.R, Param.Wup, Param.dWup, Param.dTheta, Param.ddTheta

function [ dW ] = aldW( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       dWup=Param.dWup;
       Wup=Param.Wup;
       dTheta=Param.dTheta;
       ddTheta=Param.ddTheta;
   else
       R=varargin{1};
       Wup=varargin{2};
       dWup=varargin{3};
       dTheta=varargin{4};
       ddTheta=varargin{5};
   end
   
   dW = R*dWup + Sw(R*Wup)*[0;0;dTheta] +[0;0;ddTheta];
end