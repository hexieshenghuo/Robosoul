%% 一个构建机械臂模型的临时参考模型
%% ---------Manipulator
   %% DH与结构参数
   global LinkLength;              % 设计连杆长度需要的参数，因此用global
   LinkLength=[0.18;0.18;0.15;0.03;0.06]; % 连杆长度 
   Angle=[-pi/2;pi/2;0;0;0];     % 关节初始角度
   global amDH;
   amDH=[ 0              0        0                             Angle(1);...
          LinkLength(1)  0        0                             Angle(2);...
          LinkLength(2)  -pi/2    0                             Angle(3);...
          0              -pi/2    LinkLength(3)                 Angle(4);...
          0              0        LinkLength(4)+LinkLength(5)   Angle(5)];
   
   %% Arm
   Arm.LinkNum=5;     %关节和连杆的数量 最后一个是末端执行器，固定的没有参数
   ArmLinkFileName={ 'ArmLinkModelScript_1.m',...
                     'ArmLinkModelScript_2.m',...
                     'ArmLinkModelScript_3.m',...
                     'ArmLinkModelScript_4.m',...
                     'ArmLinkModelScript_5.m'};
   
   for i=1:Arm.LinkNum
       Link(i)=alLoadModel(ArmLinkFileName{i});
       if i>1
            Link(i).Tup=Link(i-1).T;    
       end
       Link(i)=alUpdatePose( Link(i) );
       Link(i).dt=dt;
   end
  
   Arm.Link=Link;
   Arm.LinkLength=LinkLength;
   
   % 输入
   Arm.Theta=Angle;
   Arm.dTheta=zeros(Arm.LinkNum,1);
   
   %% Jacobian矩阵
   Arm.J_e2b=@Je2q; % 末端相对于平台基坐标系的Jacobian