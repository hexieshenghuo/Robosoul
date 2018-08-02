%% 配置旋翼机械臂模型
%% 包括3D模型与物理参数
%% 说明
% M: 一个旋翼机械臂的所有模型的集合结构
function [ M ] = getAMModel( varargin )
   
   %% ---------固定参数
   M.RotorNum=8;   % 旋翼数
   M.r=[1 0 0.6];  %
   
   global ArmTrans;
   ArmTrans=60;
   
   M.ArmTrans=[0 0 -ArmTrans 1]';    % 机械臂基坐标相对飞机基坐标位移
   LinkLength=[200 200 200 0];       % 机械臂连杆长度
   AerialScale=1.0;                  % 飞机模型比例
   
   %% ---------状态变量初始值
   %---------飞机平台
   M.States.EulerAngles=[0 0 0]';       %[pi/3;pi/4;pi/6]; %飞机平台欧拉角
   M.States.BasePos=[0;0;0];            %飞机自身位置
   
   M.States.BaseBodyVel=[0;0;0];        %飞机自身速度
   M.States.BaseBodyDVel=[0 0 0]';      %飞机自身加速度
   
   M.States.BaseBodyW=[0;0;0];          %飞机自身角速度
   M.States.BaseBodyDW=[0;0;0];         %飞机自身角加速度
   
   M.States.BaseResVel=[0;0;0];     %飞机世界坐标系速度
   M.States.BaseResDVel=[0 0 0]';   %飞机世界坐标系加速度

   M.States.BaseResW=[0;0;0];     %飞机世界坐标系角速度
   M.States.BaseResDW=[0;0;0];    %飞机自身角加速度
   
   M.States.BaseRotMat=EulerRotMat(M.States.EulerAngles);
   M.States.BaseTrans=[M.States.BaseRotMat M.States.BasePos;[0 0 0 1]]; %飞机相对世界坐标系变换矩阵
   
   %---------机械臂平台
   M.States.Theta=[-pi/2 0 pi/2 0]';    % 关节角度
   M.States.DTheta=[0 0 0 0]';          % 关节角速度
   M.States.DDTheta=[0 0 0 0]';         % 关节角加速度
   M.States.DH=[M.States.Theta(1) 0 LinkLength(1) 0;...
                M.States.Theta(2) 0 LinkLength(2) -pi/2;...
                M.States.Theta(3) 0 0 pi/2;...
                M.States.Theta(4) LinkLength(3) 0 0];
   M.States.JointNum=length(M.States.Theta);
   [A, T]=updateTrans( M.States.DH );
   M.States.ArmA=A;
   M.States.ArmT=T;
   
   M.States.Coord0ToBase=Trans(M.ArmTrans)*Rot(pi/2,'x'); %机械臂坐标系0到飞机机体坐标系的矩阵
   
   M.States.EndPosToBase=Vp(M.States.Coord0ToBase*M.States.ArmT{M.States.JointNum});%末端执行器相对飞机位置
   M.States.EndPosToRes=Vp(M.States.BaseTrans*M.States.Coord0ToBase*M.States.ArmT{M.States.JointNum});%末端执行器相对世界坐标系位置
   
   M.States.EndVelToBody=[0 0 0]';
   M.States.EndVelToBase=[0 0 0]';
   M.States.EndVelToRes=[0 0 0]';
   
   M.States.EndWToBody=[0 0 0]';
   M.States.EndWToBase=[0 0 0]';
   M.States.EndWToRes=[0 0 0]';
   
   %% 3D模型
   M.Component=CreateComponent();
   % --------- 飞机3D模型
   AerialComponent=getAerialModel(M.States.BaseTrans,AerialScale);
   
   % --------- 机械臂3D模型
   ArmComponent=getArmModel(M.States.ArmT,...
                            M.States.BaseTrans*M.States.Coord0ToBase,...
                            M.States.DH);
   M.Component=JointComponents(M.Component,AerialComponent);
   M.Component=JointComponents(M.Component,ArmComponent);
end