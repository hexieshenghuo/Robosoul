%% �ṩһ������ֱ�ӵ��õ�AMģ�͵Ľű�
%% ˵��
%% ���ļ����Կ���һ��ģ��

%% DH
   l=[0.2;0.2;0.16;0.09]; % ���˳��� 
   Angle=[0;0;0;0;0];     % �ؽڳ�ʼ�Ƕ�
   amDH=[ 0     0       0     Angle(1);...
          l(1)  0       0     Angle(2);...
          l(2)  -pi/2   0     Angle(3);...
          0     -pi/2   l(3)  Angle(4);...
          0     0       l(4)  Angle(5)];
         
%% Quadrotor
   QuadrotorFileName = 'QMFileName.m';
   qm=qmLoadModel(QuadrotorFileName);

%% Arm
   LinkNum=3;
   ArmLinkFileName={'','','','',''};
   
   for i=1:LinkNum
       Arm(i)=alLoadModel(ArmLinkFileName{i});
   end
   fam.qm=qm;
   fam.Arm=Arm;

%% Jacobian����
Jaco_q2e=eye(4); %
Jaco_w2e=eye(4); %
