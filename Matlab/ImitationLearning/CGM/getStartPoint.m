%% ��ʼ�����Ƶ�
%% ˵��
% Y: ����ϵ�Ŀ������
% N: ���Ƶ���
% varargin��Ϊ��ֵ����ʽ
function [Points] = getStartPoint(Y,N,varargin)
 
   [Dim,M]=size(Y);
   Points=zeros(Dim,N);
   Points(:,1)=Y(:,1);
   Points(:,N)=Y(:,M);
   
   if nargin>2
       N=length(varargin);
       for i=1:2:N
           switch varargin{i}
               case 'method'
                   switch varargin{i+1}
                       case 'OnYmean' %��Y��ƽ��������Ϊ��ʼ��
                           for i=2:N-1
                               Points(:,i)=Y(round(M/(N-1))*i);
                           end
                       case 'OnStart' % ȫ��ȡ���
                           for i=2:N-1
                               Points(:,i)=Y(:,1);
                           end
                   end
           end
       end 
   else % ��ֹ�����߾��Ȳ���
       DP=Points(:,N)-Points(:,1);
       for i=2:N-1
           Points(:,i)=Points(:,1)+DP/(N-1)*(i-1);
       end
   end
end

