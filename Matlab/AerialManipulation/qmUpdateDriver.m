%% ����ת�ٸ������������ɵĶ����������������
%% ˵�� 
% ʵ���Ǹ���qm���rm(����ģ��)�ṹ
% w��n��1 ���ת��������nΪ����ĸ���
% qm: ������ģ��

function [ qm ] = qmUpdateDriver( qm , w , varargin )
  
   %% ��
   % �ƽ���
   
   f=qm.Ktf*w;
   
   f=f.'; % 1��n
   % x y z �����
   F1=qm.Fn(1,:).*f; % 1��n
   F2=qm.Fn(2,:).*f; % 1��n
   F3=qm.Fn(3,:).*f; % 1��n
   
   F=[F1;F2;F3];% 3��n
   
   % ����
   qm.Gb=qm.rm.R.'*qm.G;% Body����ϵ�µ�����
   
   % ȫ��������rm
   qm.rm.F=[F qm.Gb];
   
   %% ����
   t=qm.Kct*w;
   t=t.';
   T1=qm.Tn(1,:).*t;
   T2=qm.Tn(2,:).*t;
   T3=qm.Tn(3,:).*t;
   
   T=[T1;T2;T3];
   
   qm.rm.T=T;
   
end