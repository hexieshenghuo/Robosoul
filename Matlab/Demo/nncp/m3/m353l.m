%m353l.m     非线性动态系统辨识：
%            仿真系统 y(k)=5y(k-1)/(2.5+y^2(k-1))+u^3(k-1)
%            辨识器用:非线性DTNN(RBFNN + 时延环节)
%            适用于离线辨识
clear all;
close all;

%----初始设置
K=150;
y=zeros(1,K); 
y1=y;
u=y;
u1=y;
E=y;
eg=0.2             ;%设目标函数
sc=1               ;%设散布(伸展)系数

%----系统输入、输出
  for k=2:K;
  u(k)=0.6*cos(2*pi*k/70)-0.4*cos(2*pi*k/40);%系统输入
  y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3     ;%系统输出
 end
 
for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
hsp=[y1;u1];                     ;%RBFNN的两个输入
net=newrb(hsp,y,eg,sc)           ;%设计辨识器（网络）
yi=sim(net,hsp);                 ;%辨识器输出

for k=1:K
    E(k)=0.5*(y(k)-yi(k))^2;
end

figure;
subplot(221),plot(u,'b');ylabel('系统、辨识器输入u');
subplot(223),plot(y,'m');ylabel('系统输出y ');xlabel('k');
subplot(222),plot(yi,'r');ylabel('辨识器输出yi');
subplot(224),plot(E);ylabel('E(k)=e(k)^2/2');xlabel('k');
w1=net.iw{1}            %观测辨识器（估计）参数
b1=net.b{1}
w2=net.lw{2}
b2=net.b{2}