%% �Զ���һά�����㷨1
%% ˵��
% Func:���Ż������ľ�� ������ʽ����Ϊ�� [f,g]=Func(X,FuncParam)
% ����XΪ���Ż��ı�����DataΪ����Func�Ĳ������
% X������
% FuncParam������
% d����������
% k:��������
% lamda0���˵ĳ�ֵ
% lamda: ���Ų���
% fk:���ŵĺ���ֵ
% gk:��ǰ���ź����ݶ�
% newX����ǰ���Ž�
%% 
function [lamda,newX,fk,gk] = getSimpleSearch1(Func,X,FuncParam,d,Simple1Param,varargin)
%% ------��ʼ��
   K=Simple1Param.K; %����������
   lamda0=Simple1Param.lamda0;%��0
   Step=Simple1Param.Step;
%% ------����
   [f,g]=Func(X,FuncParam);
   F=zeros(K,1);
   for k=1:K
       lamda=lamda0+(k-1)*Step;
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam,varargin);
       F(k)=fk;
   end
%% ------ȡ������С��
   [F,Indx]=sort(F);
   if F(1)<f
%% �����½�����
       lamda=lamda0+(Indx(1)-1)*Step;
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam,varargin);
   else
%% �������½����� ����Back��
%        BackParam=getBackParam();
%        BackParam.lamda0=lamda0;
%        [lamda,newX,fk,gk] = getBack(Func,X,FuncParam,d,BackParam,varargin);
   end
end

