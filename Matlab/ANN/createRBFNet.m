%% ����һ��RBF������
%% ˵��
% DimX :    �������X��ά��
% DimY :    �������Y��ά��
% NumHid��  ������
% C:        RBF�������� DimX��NumHid
% s:        RBF������   NumHid��1
% W��       ���Բ�Ȩֵ���� NumHid��DimY, Y=W.'H Wÿ��ΪH��Ȩֵ
% l:        �Ƿ���������W0   y=W.'H + W0*l
function [ rbf ] = createRBFNet( DimX,NumHid,DimY,varargin)
   
   r=1;
   if nargin>4
       r=varargin{2};
   end
   rbf=struct('dimX',DimX,...
              'dimY',DimY,...
              'numHid',NumHid,...
              'C',rand(DimX,NumHid)*r,...
              'S',ones(NumHid,1)*r,...
              'W',rand(NumHid,DimY)*r,...
              'W0',rand(DimY,1)*r);
   rbf.l=0;
   if nargin>3
       rbf.l=varargin{1};
   end
end