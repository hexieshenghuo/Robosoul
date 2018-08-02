%m421.m             连续系统：P(s)=1/(s(s+1))=1/(s^2+s) 
%                   离散化
clear all;
close all;

%连续----离散         
%Ts=1                              ;%采样周期
Ts=0.1;
%Ts=0.01;
den=[1 1 0];
num=[0 0 1];
sys=tf(num,den);  
dsys=c2d(sys,Ts,'zoh')             %Pd(z)
[numd,dend]=tfdata(dsys,'v')

[F,G,Q,H]=tf2ss(num,den)            %P(s)----连续状态方程 
[A,B,C,D]=c2dm(F,G,Q,H,Ts,'zoh')    %连续状态方程----离散状态方程
