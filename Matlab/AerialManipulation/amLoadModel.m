%% ���ļ��е���Aerial Manipulationģ��
%% ˵��
%
%
%
function [ amModel ] = amLoadModel( FileName )

  if ( exist(FileName,'file')==2 )% �ж��ļ�֪�����
       % disp('OK');
       run(FileName);
       if ( exist('fam','var') ==1 )% �ж�ģ�ͱ���֪�����
           amModel=fam;
       else
           fprintf('Error in amLoadModel function!\n');
           fprintf('Maybe model name is not ''fam''...\n');
       end
  else
      disp('Error in amLoadModel function!\n');
      fprintf('Maybe the model file named %s is incorrect...\n',FileName);
  end

end

