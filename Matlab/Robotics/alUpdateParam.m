%% 
%% ˵��
% aml�� ArmLinkModelģ�� 
% Param: ����ArmLinkModel�Ĳ���
% Type: ѡ�ͬ��ѡ����²�ͬ�Ĳ���
function [ aml ] = alUpdateParam( aml , Param ,Type )
   switch Type
       case 'a'     %�Ƕ�
           aml.Theta=Param;
       case 'da'    %���ٶ�
           aml.dTheta=Param;
       case 'dda'   %�Ǽ��ٶ�
           aml.ddTheta=Param;
   end
end