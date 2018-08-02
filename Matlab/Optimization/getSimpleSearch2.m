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
function [lamda,newX,fk,gk] = getSimpleSearch2(Func,X,FuncParam,d,Simple1Param,varargin)
%% ------��ʼ��
   % �������
   K=Simple1Param.K; %����������
   Gain=Simple1Param.Gain;% ��
   lamda=Simple1Param.lamda0;%��0
%% ------����
   Simple1Param.IsGradient=0;
   [f,g]=Func(X,FuncParam);
   fk=0;
   gk=0;
   for k=1:K
       newX=X+lamda*d;
       [fk,gk]=Func(newX,FuncParam);%���� f(x+��d)�� �� f(x+��d)
       if fk > f %
           %���²���
           lamda=lamda*Gain;
       else
           break;
       end
   end
   Simple1Param.IsGradient=1;
   [fk,gk]=Func(newX,FuncParam);
end