%m361l.m  2阶线性系统逆模型辨识：
%         仿真系统y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%         逆模型辨识器用：线性DTNN
%         适用于离线辨识
clear all;
close all;

%---初始设置
K=90;
y1=zeros(1,K);
y2=y1;
u1=y1;
u2=y1;
hsp=zeros(4,K);

u=prbs(4,K,4,3,0,0)'     ;%系统、辨识器输入;
num=[1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u);
z=[y u];
figure(1);
idplot2(z,1:K);ylabel('系统输入u(k)','color','r','fontsize',13);
               xlabel('(a)    k'),pause
figure(2);
plot(y,'m');ylabel('系统输出、辨识器输入y(k)','color','r','fontsize',13);
                  xlabel('(b)    k'),pause
u=u';
y=y';
for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
for k=1:K-2
    y2(k+2)=y(k);
    u2(k+2)=u(k);
end
hsp=[y;y1;y2;u2];
net=newlind(hsp,u1)    ;%设计4入、单出线性神经元
V=net.iw{1,1};              %估计参数（权值、阈值）
b=net.b{1} ;              
ui=sim(net,hsp)             ;%由输入y1(k),求辨识器输出ui(k)
z1=[y;ui]';

figure(3);
idplot2(z1,1:K);ylabel('逆模型辨识器输出ui(k)','color','r','fontsize',13);
                 xlabel('(c)    k'),pause
figure(4);
for k=1:K
    E(k)=(u1(k)-ui(k))^2/2;
end
plot(E,'b');ylabel('目标函数E(k)','color','r','fontsize',13);
                               xlabel('(d)    k'),pause

V=V'
b