%m432.m           将P(s)=1/(s(s+1))转换为离散状态空间模型
clear all;
close all;

Ts=1                             ;%设置采样周期
[F,G,Q,H]=tf2ss(1,[1,1 0])        %P(s)----连续状态空间模型 
[A,B,C,D]=c2dm(F,G,Q,H,Ts,'zoh')  %连续状态空间模型----离散状态空间模型