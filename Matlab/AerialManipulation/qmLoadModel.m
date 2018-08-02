%% ����Quadrotorģ��
%%
%
%
function [ QuadrotorModel ] = qmLoadModel( FileName )

   if ( exist(FileName,'file')==2 )% �ж��ļ�֪�����
       % disp('OK');
       run(FileName);
       if ( exist('fqm','var') ==1 )% �ж�ģ�ͱ���֪�����
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