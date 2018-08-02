%% 生成一个串联机械臂连杆（ArmLink）的模型
%% 说明
%% al前缀的函数是针对一个机械臂连杆啥的，而arm前缀的函数是针对整个一个机械臂的
% m:   质量
% I:   惯性矩阵
% dh:  该坐标系相对上一个坐标系的D-H参数，采用"第二种"D-H方法
% Tup：上一级坐标系相对世界坐标的变换,即为上一级坐标系的T
% T:   Tup×A 当前坐标系相对于世界坐标系的变换
% Aconst：A中的常量
% Avar：  A中的变量
% A：Aconst×Avar 当前坐标系相对上一级的变换矩阵
% R：MR(A)
% Theta：   θ
% dTheta：  dθ
% ddTheta： ddθ
% Pc：常量
% Vc：
% dVc：
% V：
% dV：
% W：
% dW：
% Pdown：常量 iPi+1 下级连杆坐标系原点在当前坐标系下的位置
% fup：  上级刚体作用当前的力,相对连杆自身坐标系
% fdown：下级刚体作用当前的力,相对连杆自身坐标系
% F:     合力
% G：    相对连杆自身坐标系的重力
% Model3D:
% dt

function [ AL ] = alDefaultModel( )

   AL.dh=[0 0 0 0];
   AL.m=3;
   AL.I=eye(3)*m/6;
   AL.Tup=eye(4);
   AL.T=eye(4);
   AL.Aconst=eye(4);
   AL.Avar=eye(4);
   AL.A=Aconst*Avar;
   AL.R=MR(AL.A);
   AL.Theta=0;
   AL.dTheta=0;
   AL.ddTheta=0;
   AL.Pc=[0;0;0];
   AL.Vc=[0;0;0];
   AL.dVc=[0;0;0];
   AL.V=[0;0;0];
   AL.dV=[0;0;0];
   AL.W=[0;0;0];
   AL.dW=[0;0;0];
   AL.Pdown=[0;0;0];
   AL.fup=[0;0;0];
   AL.fdown=[0;0;0];
   AL.F=[0;0;0];
   g=-9.8;
   AL.G=MR(Tup*A)*[0;0;g*m];
   AL.Model3D={};
   AL.dt=0.001;
end