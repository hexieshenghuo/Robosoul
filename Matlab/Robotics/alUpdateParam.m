%% 
%% 说明
% aml： ArmLinkModel模型 
% Param: 更新ArmLinkModel的参数
% Type: 选项不同的选项更新不同的参数
function [ aml ] = alUpdateParam( aml , Param ,Type )
   switch Type
       case 'a'     %角度
           aml.Theta=Param;
       case 'da'    %角速度
           aml.dTheta=Param;
       case 'dda'   %角加速度
           aml.ddTheta=Param;
   end
end