%% 从脚本中导入Matlab3D模型
function [ Model3d ] = Load3dModel( FileName )
   if ( exist(FileName,'file')==2 )% 判断文件知否存在
       % disp('OK');
       run(FileName);
       if ( exist('fm3d','var') ==1 )% 判断模型变量知否存在
           Model3d=fm3d;
           
       else
           Model3d={};
           fprintf('Error in Load3dModel...\nhave not fm3d...\n');
       end
   else
       Model3d={};
       fprintf('Error in Load3dModel...\nMaybe error in FileName...\n');
   end
end

