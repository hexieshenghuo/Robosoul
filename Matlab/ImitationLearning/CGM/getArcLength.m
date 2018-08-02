%% �������߸����������㻡����ռ�������ı���
%% ˵��
% ArcLength�� �����㵽���Ļ��� N��1
% ArcRatio��  ����Ļ�������    N��1
% N�� �����
function [ArcLength,ArcRatio] = getArcLength(Curve)
   [Dim,N]=size(Curve);% Dim ��ά�� N �����
   SectionLength=zeros(N,1);
   ArcLength=zeros(N,1);
   ArcRatio=zeros(N,1);
   SectionLength(1)=0; % ���λ���
   ArcLength(1)=0;
   ArcRatio(1)=0;
   
   for i=2:N
       SectionLength(i)=norm(Curve(:,i)-Curve(:,i-1));
       ArcLength(i)=sum(SectionLength(1:i)); %
   end
   
   ArcRatio=ArcLength/ArcLength(N);
   
end