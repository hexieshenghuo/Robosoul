%% ���ݸ����ؽڽǶȺͻ�����任�������Armģ��λ��
%% ˵��
%
%
%
function [ arm ] = armUpdatePose( arm,Angle,BaseT)

   arm.Link(1)=alUpdatePose(arm.Link(1),Angle(1),BaseT);
   for i=2:arm.LinkNum
       arm.Link(i)=alUpdatePose(arm.Link(i),Angle(i),arm.Link(i-1).T);
   end
   
end

