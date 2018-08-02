%% 导入Quadrotor模型
%%
%
%
function [ QuadrotorModel ] = qmLoadModel( FileName )

   if ( exist(FileName,'file')==2 )% 判断文件知否存在
       % disp('OK');
       run(FileName);
       if ( exist('fqm','var') ==1 )% 判断模型变量知否存在
           QuadrotorModel=fqm;
       else
           fprintf('Error in qmLoadModel...\nhave not fqm...\n');
           QuadrotorModel=qmDefaultQuadrotorModel();
       end
   else
       fprintf('Error in qmLoadModel...\nMaybe error in FileName...\n');
       QuadrotorModel=qmDefaultQuadrotorModel();
   end
end