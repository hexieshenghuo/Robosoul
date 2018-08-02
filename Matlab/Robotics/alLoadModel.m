%% 从m文件中导入al模型
%% 
% FileName: 模型文件名 .m文件
% falm: file arm link model
function [ ArmLinkModel ] = alLoadModel( FileName )

   if ( exist(FileName,'file')==2 )% 判断文件知否存在
       % disp('OK');
       run(FileName);
       if ( exist('falm','var') ==1 )% 判断模型变量知否存在
           ArmLinkModel=falm;
       else
           ArmLinkModel=alDefaultModel();
       end
   else
       ArmLinkModel=alDefaultModel();
   end
   
end