%% �����ݶ��½��㷨
%% ˵�� 
% lamda: ����

function [newX,fk,gk,varargout] = GD(Func,X,FuncParam,GDParam,varargin)
%% ------��ʼ��
   SearchParam=GDParam.SearchParam;
%% ------��ȡ�ݶȺ��½�����
   [f,g]=Func(X,FuncParam,varargin);
   d=-g; %�½�����
%% ----һά����������   
   [lamda,newX,fk,gk]=lineSearch(Func,X,FuncParam,d,SearchParam,varargin);
%% ����
   if nargin>4
       varargout{1}=lamda;
   end
end