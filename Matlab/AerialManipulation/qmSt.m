%% 耦合矩阵辅助函数
%% 详见技术报告/Robotics/多旋翼解耦
%% 说明
%% r 3×1力臂向量
%% 
function [ S ] = qmSt( r,Ktf,Kct,Sign)
   S1=Sw(r)*Ktf;
   S2=eye(3)*Sign*Kct;
   S=S1+S2;
end

