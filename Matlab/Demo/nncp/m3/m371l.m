%m371l.m    非线性系统逆模型辨识：
%           仿真系统 y(k)=0.8sin[y(k-1)]+1.2u(k-1)
%           逆辨识器用:非线性DTNN(RBFNN + 时延环节)
%           离线辨识
clear all;
close all;

%---初始设置
K=150;
eg=0.2                ;%设目标函数（均方差）精度
sc=1                  ;%设散布(伸展)函数
y=zeros(1,K);
y1=y;
u1=y;

u=rand(1,K)-0.5;        %系统输入
  for k=2:K;
  y(k)=0.8*sin(y(k-1))+1.2*u(k-1);%系统输出
 end

for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
 hsp=[y;y1]                 ;%RBFNN的两个输入
net=newrb(hsp,u1,eg,sc)     ;%设计网络
ui=sim(net,hsp);            ;%辨识器输出
E=zeros(1,K);
for k=1:K
    E(k)=0.5*(u1(k)-ui(k))^2;
end

figure;
subplot(221),plot(u,'b');ylabel('系统输入u');
subplot(223),plot(y,'b');ylabel('系统输出y');xlabel('k');
subplot(222),plot(ui,'r');ylabel('逆模型辨识器输出ui ');
subplot(224),plot(E);ylabel('目标函数E(k)');xlabel('k');
w1=net.iw{1}            %观测估计（网络）参数
b1=net.b{1}
w2=net.lw{2}
b2=net.b{2}


