%% ��Ͼ���������
%% �����������/Robotics/���������
%% ˵��
%% r 3��1��������
%% 
function [ S ] = qmSt( r,Ktf,Kct,Sign)
   S1=Sw(r)*Ktf;
   S2=eye(3)*Sign*Kct;
   S=S1+S2;
end

