%% 生成一个有刚体动力学特性的3D模型
%% 用于Demo_1程序
function [ Model ] = getModel()
   Model.J=50;       % 转动惯量
   Model.k=0.00258;       % 螺旋桨系数
   Model.r=15;       % 力臂
   
   Model.Angle=60*pi/180;  %顺时针为正弧度制
   Model.Omiga=0;    %角速度
   Model.dOmiga=0;   %角角速度!
   
   %
   Model.ThreeDModel=GetBox(20,6,6);
   Model.T=10;       %控制周期10ms
end
