%% һά����
%% ˵��
% Func: �����ĺ���
% X����ǰ����
% FuncParam:Func �������������
% d����������
% SearchParam����������
% lamda: ����

%% 
function [lamda,newX,fk,gk] = lineSearch(Func,X,FuncParam,d,SearchParam,varargin)
   switch SearchParam.Method
       case 'WolfePowell'
           [lamda,newX,fk,gk]=getWolfePowell(Func,X,FuncParam,d,SearchParam,varargin);
       case 'Back'
           [lamda,newX,fk,gk]=getBack(Func,X,FuncParam,d,SearchParam,varargin);
       case 'Simple1'
           [lamda,newX,fk,gk]=getSimpleSearch1(Func,X,FuncParam,d,SearchParam,varargin);
       case 'Simple2'
           [lamda,newX,fk,gk]=getSimpleSearch2(Func,X,FuncParam,d,SearchParam,varargin);
       case 'Const' %����
           lamda=SearchParam.lamda;
           newX=X+lamda*d;
           [fk,gk]=Func(newX,FuncParam);
       case 'Random'
           [lamda,newX,fk,gk]=getRandom(Func,X,FuncParam,d,SearchParam,varargin);
       otherwise
   end   
end