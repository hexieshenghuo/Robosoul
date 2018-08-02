%% ���˸��嶯��ѧ ���� F ���㺯��
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
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

