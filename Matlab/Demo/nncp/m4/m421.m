%m421.m             ����ϵͳ��P(s)=1/(s(s+1))=1/(s^2+s) 
%                   ��ɢ��
clear all;
close all;

%����----��ɢ         
%Ts=1                              ;%��������
Ts=0.1;
%Ts=0.01;
den=[1 1 0];
num=[0 0 1];
sys=tf(num,den);  
dsys=c2d(sys,Ts,'zoh')             %Pd(z)
[numd,dend]=tfdata(dsys,'v')

[F,G,Q,H]=tf2ss(num,den)            %P(s)----����״̬���� 
[A,B,C,D]=c2dm(F,G,Q,H,Ts,'zoh')    %����״̬����----��ɢ״̬����
