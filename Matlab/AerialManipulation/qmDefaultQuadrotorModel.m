%% 生成一个默认的四旋翼飞机模型
%% 说明
% 模型是基于Robotics的刚体模型，再加入四旋翼特有参数
% 模型的力、力臂和转矩的排序是：电机推进力(矩)、重力、其他系统的作用力(矩)、其他扰动力(矩)

function [ QM ] = qmDefaultQuadrotorModel( )
   
   %% 默认刚体模型
   QM.rm=rmDefaultRigidModel();
   
   %% 模型参数
   QM.Kct=3.12e-07;        % 电机反转矩系数 电机给本体的转矩   = 浆转速的平方×Kct
   QM.Ktf= 3.16e-05;    % 电机牵引力系数 螺旋桨相对本体的力 = 浆转速的平方×Ktf
   
   QM.l=0.2;           %力臂
   QM.rF=[[QM.l;0;0] [0;QM.l;0] [-QM.l;0;0] [0;-QM.l;0]];
   
   QM.rm.r=[QM.rF [0;0;0]]; %
   
   QM.Fn=[[0;0;1] [0;0;1] [0;0;1] [0;0;1]];    %推进力的方向
   QM.Tn=[[0;0;1] [0;0;-1] [0;0;1] [0;0;-1]];  %电机的反转矩的方向
   
   s=size(QM.Fn);
   QM.RotorNum=s(2);  % 4旋翼
   
   QM = qmCoupleMat( QM );
   
   %% 初始化力
   % 重力
   g=-9.8;
   QM.G=[0;0;QM.rm.m*g];
   
end