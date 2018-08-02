%% ���˸��嶯��ѧ ���ٶ� d�� ���㺯��
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
% R�� 
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