

N=8; %控制点数 
k=3; %阶次
Range=10;%控制点的范围
dt=0.01;%曲线间隔
P1=getControlPoints(N,Range);% GUI方式得到控制点

P2=getControlPoints(N,Range);% GUI方式得到控制点
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