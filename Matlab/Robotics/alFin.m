%% ���˸��嶯��ѧ ������ fi ���㺯��
%% fi ������i-1��������i���� ��������i�µı�ʾ
%% �ݹ� Newton-Euler���� �ο��������桶��е�۶���ѧ_Newton-Euler��
%% ˵��
% R : ע�� iRi+1 ������  i+1Ri 
% fout
% Fsum
% vargin: Param.R Param.fout Param.Fsum
function [ fin ] = alFin( varargin )
   if(nargin==1)
       Param=varargin{1};
       R=Param.R;
       fout=Param.fout;
       Fsum=Param.Fsum;
   else
       R=varargin{1};
       fout=varargin{2};
       Fsum=varargin{3};
   end
   fin= R*fout + Fsum;
end