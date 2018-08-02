%% 从m文件模型
%% 
% FileName: 模型文件名 .m文件

function [ RigidModel ] = rmLoadModel( FileName )
   if ( exist(FileName,'file')==2 )% 判断文件知否存在
       % disp('OK');
       run(FileName);
       if ( exist('frm','var') ==1 )% 判断模型变量知否存在
           RigidModel=frm;
       else
           fprintf('Error in function rmLoadModel()\nMaybe frm is wrong...\n');
           RigidModel=rmDefaultRigidModel();
       end
   else
       fprintf('Error in function rmLoadModel()\nMaybe FileName is wrong...\n');
       RigidModel=rmDefaultRigidModel();
   end
end

