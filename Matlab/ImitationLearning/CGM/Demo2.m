%% Demo2 生成B-Spline 曲线
% N: 控制点数
% k：阶数
% Range：点的取值范围
% dt:间隔

N=6; %控制点数 
k=3; %阶次
Range=10;%控制点的范围
dt=0.01;%曲线间隔
P=getControlPoints(N,Range);% GUI方式得到控制点
figure(1);

C=createBSplineCurve(P,k,dt);
drawControlPoints(P);hold on;
DrawCurve(C);hold on;