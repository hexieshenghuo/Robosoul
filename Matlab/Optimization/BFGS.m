%% BFGS�Ż��㷨��������
%% ˵��
% Func:���Ż������ľ�� ������ʽ����Ϊ�� [f,g]=Func(X,Data)
% X���������������Ż��ı���
% ���XΪ ��ǰ���Ž�
% fk����ǰ���ź���ֵ
% gk����ǰ���Ž��ݶ�
% Data�������г������ݣ��������
% H��BFGS��������
% bfgsParam:�㷨����

%%
function [newX,H,fk,gk] = BFGS( Func,X, Data, H, bfgsParam,varargin)

%% ------��ʼ��
   dim=length(X);% ����ά��
   SearchParam=bfgsParam.SearchParam;

%% ------�ж�H�Ƿ�����
   res=isPositiveDefinite(H);
   if res==0
       H=eye(dim);
   end
%% ------����f g
   [f,g]=Func(X,Data);

%% ------�������������½�����d
   d=-H*g;

%% ------����һά����Ѱ���Ų���
   [lamda,newX,fk,gk]=lineSearch(Func,X,FuncParam,d,SearchParam,varargin);

%% ------����H
   s=newX-X;
   y=gk-g;
   gamma=1/(y'*s);%��
   I=eye(dim);
   H=(I-gamma*s*y')*H*(I-gamma*y*s')+gamma*s*s';

%% ------����
   if bfgsParam.Test==1
       Str=sprintf('������%f',lamda);
       disp(Str);
   end
end