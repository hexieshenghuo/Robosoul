%% �����ⲿ���뵥�����¸���ģ��λ��
% rm:����ģ��
% P������ϵԭ�������������ϵ��λ��
% Pose:��̬���� �����3��1���� Ϊŷ���ǣ������3��3����ô������ת����
function [ rm ] = rmUpdatePose(rm,P,Pose)

   rm.P=P;
   s=size(Pose);
   if s(2)==1 % 3��1 ��Ϊ��ŷ����
       rm.Euler=Pose;
       rm.R=EulerRotMat(Pose);
   else       % 3��3 ��Ϊ��R
       rm.R=Pose;
   end
end