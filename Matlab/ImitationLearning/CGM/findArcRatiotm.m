%% ������Y�����㻡��Լ����ӦBSpline���ߵĲ�����
%% ˵��
% Ytm: ÿ��Yi���Ӧ��BSpline�������
% SC :B-Spline����
% varargin{1}: dt
function [Ytm] = findArcRatiotm(Y,Points,k,varargin)
%------��ʼ��   
   [Dim,N]=size(Points);
   T=getT(N,k);
   dt=0.001;
   if nargin>3 %�ⲿ��ֵ
       dt=varargin{1};
   end
%------����BSpline����
   [SC,t]=createBSplineCurve(Points,k,dt); %

%------���㻡��
   [YArcLength,YArcRatio]=getArcLength(Y);
   [SCArcLength,SCArcRatio]=getArcLength(SC);

%------���Ҷ�Ӧ����tm
   M=length(Y);  %Y����
   %thres=1/M*0.005;% ���ܱ�����ֵ
   Ytm=zeros(1,M);% tmΪ������
   
   i=2;          %Spline�������
   n=length(t);%����
   for m=2:M
       for j=i:n
           if YArcRatio(m)>=SCArcRatio(j-1) & YArcRatio(m)<=SCArcRatio(j)
               Ytm(m)=t(j - ( YArcRatio(m)-SCArcRatio(j-1) < SCArcRatio(j) - YArcRatio(m)) );
               i=max(2,j-1);% Ϊ�˴����ٶ�Ϊ0�Ĺ켣�� +1
%                i=max(2,j - ( YArcRatio(m)-SCArcRatio(j-1) < SCArcRatio(j) - YArcRatio(m)) )+1;
               break;
           end
       end
   end
end