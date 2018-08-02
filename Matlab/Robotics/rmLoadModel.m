%% ��m�ļ�ģ��
%% 
% FileName: ģ���ļ��� .m�ļ�

function [ RigidModel ] = rmLoadModel( FileName )
   if ( exist(FileName,'file')==2 )% �ж��ļ�֪�����
       % disp('OK');
       run(FileName);
       if ( exist('frm','var') ==1 )% �ж�ģ�ͱ���֪�����
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

