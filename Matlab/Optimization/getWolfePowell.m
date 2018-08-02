%% ����Wolfe Powell׼�� һά��������lamda ��

%% �ο���

%% ˵��
% Func:���Ż������ľ�� ������ʽ����Ϊ�� [f,g]=Func(X,Data)
% ����XΪ���Ż��ı�����DataΪ����Func�Ĳ������
% X������
% Data������
% d����������
% rho���� ׼�����
% sigma���� ׼�����
% k:��������
% gain:���� �����еĦ� �����ظ���Gain
% lamda0���˵ĳ�ֵ
% lamda: ���Ų���
% fk:���ŵĺ���ֵ
% gk:��ǰ���ź����ݶ�
% newX����ǰ���Ž�

%%
function [lamda,newX,fk,gk]=getWolfePowell(Func,X,Data,d,WolfeParam,varargin)

%��ʼ��
   % �������
   rho=WolfeParam.rho; %������˵��
   sigma=WolfeParam.sigma;%������˵��
   K=WolfeParam.K; %����������
   Method=WolfeParam.Method;
   Gain=WolfeParam.Gain;% ��
   lamda0=WolfeParam.lamda0;%��0
   
   % ���в���
   a=0;
   M=10000000;
   b=M;
   lamda=lamda0;

   if Method==1 % ��һ�ַ���
       % ���� f(x)�먌f(x)
       [f,g]=Func(X,Data);
       Gd=g'*d;% ��f(x)'d
       fk=0;
       gk=0;
       for k=1:K
           [fk,gk]=Func(X+lamda*d,Data);%���� f(x+��d)�� �� f(x+��d)
           if fk <= f+rho*lamda*Gd % if f(x+��d)��f(x)+�Ѧ˨�f(x)'d (����1)
               if gk'*d >= sigma*Gd % if ��f(x+��d)'d�ݦҨ�f(x)'d  (����2)
                   break;
               end
               a=lamda;
               % b=b;
               if b==M;
                   lamda=Gain*lamda;
                   continue;
               end
           else %����������1
               % a=a;
               b=lamda;
           end
           lamda=(a+b)/2;
       end
   end
   
   if Method==2 % �ڶ��ַ��� û���
       [f,g]=Func(X,Data);
       for k=1:K
           [fk,gk]=Func(X+lamda*d);      
           if  fk <= f + rho*lamda* g'*d %����1           
               if gk'*d>=sigma*g'*d      %����2
                   break;
               else
                   newlamda=lamda+ (lamda-a)*gk'*d /(g'*d-gk'*d);
                   a=lamda;
                   f=fk;
                   g=gk;
                   lamda=newlamda;
               end
           else %����������1
               newlamda=1;
           end
       end
   end
   
   % ˳�����X
   newX=X+lamda*d;
   if nargin>5
       str=sprintf('������%f\n',lamda);
       disp(str);
   end
end