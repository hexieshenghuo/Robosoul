%% Demo3 ���ɾֲ���B-Spline ���߶�
% N: ���Ƶ���
% k������
% Range�����ȡֵ��Χ

N=6;
k=3;
Range=10;
t=1.58;
range=0.3;

P=getControlPoints(N,Range);
figure(1);

C=createLocalBSplineCurve(P,k,0.1,t,range);
drawControlPoints(P);hold on;
plot(C(1,:),C(2,:),'linewidth',1.8);hold on;