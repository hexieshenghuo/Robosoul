%% ���˸��嶯��ѧ ���� F ���㺯��
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
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

