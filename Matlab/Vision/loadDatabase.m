%% �������ݿ�Database
%% ˵��
%% 
function [Database] = loadDatabase(FileName)
   db=load(FileName);
   Database=db.Database;
end