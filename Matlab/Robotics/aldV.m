%% ���˸��嶯��ѧ ���ٶ� dV ���㺯��
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
% R�� 
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