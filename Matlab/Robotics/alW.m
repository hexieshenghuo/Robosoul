%% 连杆刚体动力学 角速度 ω 计算函数
%% 递归 Newton-Euler方程 参考技术报告《机械臂动力学_Newton-Euler》
%% 说明
% R： 
% Wup:    
% dTheta:

% vargin: Param.R Param.Wup Param.dTheta

function [ W ] = alW( varargin )
   % 参数
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       dTheta=Param.dTheta;
       Wup=Param.Wup;
   else
       R=varargin{1};
       Wup=varargin{2};
       dTheta=varargin{3};
   end
   W=R*Wup + dTheta*[0;0;1];
   
end

