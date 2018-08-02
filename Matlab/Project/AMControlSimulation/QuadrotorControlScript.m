%% 四旋翼模型脚本

   %% 导入刚体模型
   fqm.rm=rmLoadModel('RigidControl.m');
   
   %% 四旋翼模型参数
   fqm.Ktf=3.16e-05;           % 电机牵引力系数 螺旋桨相对本体的力 = 浆转速的平方×Ktf
   fqm.Kct=3.13e-07;           % 电机反转矩系数 电机给本体的转矩   = 浆转速的平方×Kct
   
   fqm.l=0.2;              %力臂
   fqm.rF=[[fqm.l;0;0] [0;fqm.l;0] [-fqm.l;0;0] [0;-fqm.l;0]];
   
   fqm.rm.r=[fqm.rF [0;0;0]]; %
   
   fqm.Fn=[[0;0;1] [0;0;1] [0;0;1] [0;0;1]];   % 推进力的方向
   fqm.Tn=[[0;0;1] [0;0;-1] [0;0;1] [0;0;-1]]; % 电机的反转矩的方向
   
   s=size(fqm.rF);
   fqm.RotorNum=s(2);
   
   fqm.MaxW=300000; % 最大转数平方 ω^2 
   
   fqm = qmCoupleMat( fqm );
   
   %% 初始化力
   % 重力
   g=-9.8;
   fqm.G=[0;0;fqm.rm.m*g];