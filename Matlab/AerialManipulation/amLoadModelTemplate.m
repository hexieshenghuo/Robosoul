%% 提供一个可以直接调用的AM模型的脚本
%% 说明
%% 本文件可以看作一个模板

%% DH
   l=[0.2;0.2;0.16;0.09]; % 连杆长度 
   Angle=[0;0;0;0;0];     % 关节初始角度
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

%% Jacobian矩阵
Jaco_q2e=eye(4); %
Jaco_w2e=eye(4); %
