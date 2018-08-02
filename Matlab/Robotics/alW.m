%% ���˸��嶯��ѧ ���ٶ� �� ���㺯��
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
% R�� 
% Wup:    
% dTheta:

% vargin: Param.R Param.Wup Param.dTheta

function [ W ] = alW( varargin )
   % ����
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

