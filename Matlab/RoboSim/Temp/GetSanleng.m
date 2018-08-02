%% ���һ��Box�ĵ㼯��ͨ������㼯�Ͽ��Ի���һ������
%% ˵��
% Box������Ϊԭ��[0, 0, 0]
% OffsetΪƫ���������� ��[1 2 3 0]' ���һ�����Ϊ��
% varargin{1}:Offset;
% P Ϊ4��24���� ÿ4��Ϊһ���� һ��5����
%% 
function [P] = GetSanleng(Length,Width,Height,varargin)

   Offset=[0 0 0 0]';
   if nargin>3
       Offset=varargin{1};
   end

P=[];
%�㳤��ߵ�һ��!
hL=Length/2;
hW=Width/2;
hH=Height/2;%z

One=[1 1 1 1];
%��ƫ�ƾ���
offset=[Offset,Offset,Offset,Offset];

% plane   bottom1,2,3,4
%BottomX=[-hL hL hL -hL];
%BottomY=[-hW -hW hW hW];
%BottomZ=[-hH -hH -hH -hH];
BottomX=[-hL hL hL -hL];
BottomY=[-hW -hW hW hW];
BottomZ=[-hH -hH -hH -hH];
P_Bottom=[BottomX;BottomY;BottomZ;One];
P_Bottom=P_Bottom+offset;%��ƫ��
P=[P P_Bottom];

% ront����1,2,5,5  �����������Σ����ұ�������ά�ģ��������һ�����ظ�
FrontX=[-hL hL -hL -hL];
FrontY=[-hW -hW -hW -hW];
FrontZ=[-hH -hH hH hH];
P_Front=[FrontX;FrontY;FrontZ;One];
P_Front=P_Front+offset;%��ƫ��
P=[P P_Front];

% ����2  2,3,6,5
BackX=[hL hL -hL -hL];
BackY=[-hW hW hW -hW];
BackZ=[-hH -hH hH hH];
P_Back=[BackX;BackY;BackZ;One];
P_Back=P_Back+offset;%��ƫ��
P=[P P_Back];

% ����3��4,6,6
LeftX=[hL -hL -hL -hL];
LeftY=[hW hW hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%��ƫ��
P=[P P_Left];
% ���� ����   4,1,5,6
LeftX=[-hL -hL -hL -hL];
LeftY=[hW -hW -hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%��ƫ��
P=[P P_Left];

end