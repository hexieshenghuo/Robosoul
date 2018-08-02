%% ���˸��嶯��ѧ �������� Ni ���㺯��
%% Ni ������i-1��������i���� ��������i�µı�ʾ
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
% R : ע�� iRi+1 ������  i+1Ri 
% Nsum
% Nout
% fin
% fout
% Pdown
% Pc
% vargin: Param.R Param.fout Param.Fsum
function [ Nin ] = alNin( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       Nsum=Param.Nsum;
       Nout=Param.Nout;
       fin=Param.fin;
       fout=Param.fout;
       Pdown=Param.Pdown;
       Pc=Param.Pc;
   else
       R=varargin{1};
       Nsum=varargin{2};
       Nout=varargin{3};
       fin=varargin{4};
       fout=varargin{5};
       Pdown=varargin{6};
       Pc=varargin{7};
   end
   Nin= Nsum + R*Nout + Sw(Pc)*fin + Sw(Pdown)*(R*fout);
end