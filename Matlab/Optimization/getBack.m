%% ���˷�һά����
%% ˵��
% Func:���Ż������ľ�� ������ʽ����Ϊ�� [f,g]=Func(X,FuncParam)
% ����XΪ���Ż��ı�����DataΪ����Func�Ĳ������
% X������
% FuncParam������
% d����������
% rho���� ׼�����
% K:��������
% gain:���� �����еĦ� �����ظ���Gain
% lamda0���˵ĳ�ֵ
% lamda: ���Ų���
% fk:���ŵĺ���ֵ
% gk:��ǰ���ź����ݶ�
% newX����ǰ���Ž�
%% 
function [lamda,newX,fk,gk] = getBack(Func,X,FuncParam,d,BackParam,varargin)
%% ------��ʼ��
   % �������
   rho=BackParam.rho; %������˵��
   K=BackParam.K; %����������
   Gain=BackParam.Gain;% ��
   lamda=BackParam.lamda0;%��0
%% ------����   
   [f,g]=Func(X,FuncParam);
   Gd=g'*d;% ��f(x)'d
   fk=0;
   gk=0;
   for k=1:K
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam);%���� f(x+��d)�� �� f(x+��d)
       if fk > f+rho*lamda*Gd % if f(x+��d)��f(x)+�Ѧ˨�f(x)'d (����1)
           %���²���
           lamda=lamda*Gain;
       else
           break;
       end
   end
end