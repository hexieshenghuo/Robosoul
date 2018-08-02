%% 生成一个具有动力学属性的刚体默认参数模型
%% 说明
% Ωw ≠ Ωb
%
% m:        质量
% I:        质心惯性张量
% Euler:    3×1 xyz欧拉角 θ φ γ
% dEuler:   3×1 欧拉角导数 dθ dφ dγ
% Je_b:     3×3 欧拉角与自身坐标系角速度Jacobian
% Je_w:     3×3 欧拉角与世界坐标系角速度Jacobian
% R:        3×3相对世界坐标系的旋转矩阵
% P:        3×1坐标系原点相对世界坐标系的位置
% W_w：     3×1相对世界坐标系的角速度
% W_b：     3×1相对当前坐标系的角速度  
% V_w       3×1dP 坐标系原点相对世界坐标系的速度 Vw
% V_b       3×1坐标系原点相对本体坐标系的速度    Vb   RVb=dP=Vw
% Omi_w     3×1坐标系相对世界坐标系的角加速度    Ωw
% Omi_b     3×1坐标系相对刚体坐标系的角加速度    Ωb  dVb
% Acc_w     3×1坐标系相对世界坐标系的加速度   
% Acc_b     3×1坐标系相对刚体坐标系的加速度
% F         3×n刚体受力相对于body坐标系
% r         3×n力臂相对于body坐标系
% T         3×n转矩相对于body坐标系
% SumF      3×n 合力
% SumT      3×1和力矩
% dt        时间间隔单位s
% K         3×3 定轴旋转矩阵
% Model3d   3D模型

function [ RM ] = rmDefaultRigidModel()
   %%
   RM.m=1;
   RM.I=eye(3)/6;
   
   RM.Euler=[0;0;0];
   RM.dEuler=[0;0;0];
   RM.Je_b=EulerJacobian(RM.Euler,'xyz','b');
   RM.Je_w=EulerJacobian(RM.Euler,'xyz','w');
   
   RM.R=eye(3); 
   RM.P=[0;0;0];
   RM.K=eye(3);
   
   RM.W_w=[0;0;0];
   RM.W_b=[0;0;0];
  
   RM.V_w=[0;0;0];
   RM.V_b=[0;0;0];

   RM.Omi_w=[0;0;0];
   RM.Omi_b=[0;0;0];
   RM.Acc_w=[0;0;0];
   RM.Acc_b=[0;0;0];
   
   %% 初始力与力矩
   RM.F=[];
   RM.r=[];
   RM.T =[];
   RM.SumF =[];
   RM.SumT =[];
   
   RM.dt=0.02;
   
   RM.Model3d={};
   
end

