%% 加载数据库Database
%% 说明
%% 
function [Database] = loadDatabase(FileName)
   db=load(FileName);
   Database=db.Database;
end