%% ����B-Spline����
% P:���Ƶ� Dim��N  Dim��ά�� N������
% k:����
% dt:���
% Curve:Dim��Num, Num:���ߵ��� Dim������ά��
% t: �������� 
function [Curve,t] = createBSplineCurve(P,k,dt,varargin)
   [Dim,N]=size(P); % Dim: ���ߵ�ά��
   T=getT(N,k);
   if nargin>3
       t=varargin{1};
   else
       t=gent(T,dt);
   end 
   Curve=zeros(Dim,length(t)); 
   % ------������������ʽ
   for j=1:Dim
       for i=1:N
           Curve(j,:)=Curve(j,:)+P(j,i).*B(t,i,k,T);% ���д���Ϊ����������Curve(j,:)Ϊ����
       end
   end
    % ------����Ϊ��������ʽ
%  for j=1:length(t)
%      Curve(:,j)=getBSplinePoint(t(j),P,T,k,N,Dim);
%  end

end

