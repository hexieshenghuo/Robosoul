%% Demo2 ����B-Spline ����
% N: ���Ƶ���
% k������
% Range�����ȡֵ��Χ
% dt:���

N=6; %���Ƶ��� 
k=3; %�״�
Range=10;%���Ƶ�ķ�Χ
dt=0.01;%���߼��
P=getControlPoints(N,Range);% GUI��ʽ�õ����Ƶ�
figure(1);

C=createBSplineCurve(P,k,dt);
drawControlPoints(P);hold on;
DrawCurve(C);hold on;