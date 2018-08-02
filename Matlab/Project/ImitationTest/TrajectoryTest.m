

N=8; %���Ƶ��� 
k=3; %�״�
Range=10;%���Ƶ�ķ�Χ
dt=0.01;%���߼��
P1=getControlPoints(N,Range);% GUI��ʽ�õ����Ƶ�

P2=getControlPoints(N,Range);% GUI��ʽ�õ����Ƶ�
figure(1);

C1=createBSplineCurve(P1,k,dt);
C2=createBSplineCurve(P2,k,dt);

drawControlPoints(P1);hold on;
drawControlPoints(P2);hold on;

DrawCurve(C1);hold on;
DrawCurve(C2);hold on;

Vel1=diff(C1');
Vel2=diff(C2');

figure(2);
DrawCurve(Vel1');hold on;
DrawCurve(Vel2');hold on;

Acc1=diff(Vel1);
Acc2=diff(Vel2);

figure(3);

DrawCurve(Acc1');hold on;
DrawCurve(Acc2');hold on;