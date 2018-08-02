%% 从文件中导入Aerial Manipulation模型
%% 说明
%
%
%
function [ amModel ] = amLoadModel( FileName )

  if ( exist(FileName,'file')==2 )% 判断文件知否存在
       % disp('OK');
       run(FileName);
       if ( exist('fam','var') ==1 )% 判断模型变量知否存在
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

