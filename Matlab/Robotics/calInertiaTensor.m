%% ������������������ϵ������ԭ��λ�����ģ��Ĺ�����������
%% ˵�� ������ʾ���
% I�� 3��3������������
% Type: ����ļ�������
% 'b' -cuboid    ������
% 's' -sphere    ����
% 'c' -cylinder  Բ����
% '+' -cross     ʮ�ּܽṹ,������������ṹ
% Param��n��1 ����������Type��ͬ��ʽ��ͬ
% Pc: varargin{1}, 3��1��������������������ϵ��A����Iʱ��Ҫ�Ĳ�����P�Ǹ��������ڣ�A����λ��
% Ia��Ic�Ĺ�ϵ�ο���������ѧ���ۡ�P135 (6-26)ʽ

function [ I ,varargout] = calInertiaTensor( Type, Param,varargin)
   Pc=[0;0;0];
  
   if nargin>2 % ����Pc
       Pc=varargin{1};
   end
   
   Ic=eye(3);
   
   switch Type
       case 'b' % ������
           l=Param(1);% �� x
           w=Param(2);% �� y
           h=Param(3);% �� z
           m=Param(4); % ����
           Ic=diag([h^2+w^2; h^2+l^2 ; l^2+ w^2 ])*m/12;
       case '+' % ʮ�ּ�
           l=Param(1);% �� x
           w=Param(2);% �� y
           h=Param(3);% �� z
           m=Param(4); % ����
           s=min(l,w);
           % ����m
           ms=s/max(l,w)*m;
           Ic1=diag([h^2+w^2; h^2+l^2 ; l^2+ w^2 ])*m/12;
           Ic2=diag([h^2+l^2; h^2+w^2 ; l^2+ w^2 ])*m/12;
           Ic3=diag([h^2+s^2; h^2+s^2 ; s^2+ s^2 ])*ms/12;
           Ic=Ic1+Ic2-Ic3;
       case 'c' % Բ����
       case 's' % ����
   end
   
   I=Ic + m*(Pc.'*Pc*eye(3)-Pc*Pc.'); %��������ѧ���ۡ� P135 ��6-26��ʽ
   
   if nargout>1 %���Ic
       varargout{1}=Ic;
   end
end