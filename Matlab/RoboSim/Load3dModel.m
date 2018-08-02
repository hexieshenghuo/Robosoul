%% �ӽű��е���Matlab3Dģ��
function [ Model3d ] = Load3dModel( FileName )
   if ( exist(FileName,'file')==2 )% �ж��ļ�֪�����
       % disp('OK');
       run(FileName);
       if ( exist('fm3d','var') ==1 )% �ж�ģ�ͱ���֪�����
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

