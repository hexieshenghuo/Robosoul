%% ��m�ļ��е���alģ��
%% 
% FileName: ģ���ļ��� .m�ļ�
% falm: file arm link model
function [ ArmLinkModel ] = alLoadModel( FileName )

   if ( exist(FileName,'file')==2 )% �ж��ļ�֪�����
       % disp('OK');
       run(FileName);
       if ( exist('falm','var') ==1 )% �ж�ģ�ͱ���֪�����
           ArmLinkModel=falm;
       else
           ArmLinkModel=alDefaultModel();
       end
   else
       ArmLinkModel=alDefaultModel();
   end
   
end