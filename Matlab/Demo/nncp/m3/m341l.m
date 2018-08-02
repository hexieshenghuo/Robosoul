%m341l.m    2阶线性动态系统辨识：
%           仿真系统: y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%           线性DTNN(自适应线性神经元+TDL)应用
%           适用于离线辨识
clear all;
close all;

%---初始设置
K=90;
y1=zeros(1,K);
y2=y1;
u1=y1;
u2=y1;

u=prbs(4,K,4,3,0,0)'           ;%系统、辨识器输入
num=[1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u)              ;%系统输出
z=[y u];
figure(1);
idplot2(z,1:K)                  ;%画系统输出
figure(2);
plot(y,'m');ylabel('系统输出y(k)','color','r','fontsize',13);
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

hsp=[-y1;-y2;u1;u2]        ;%构造神经元输入
net=newlind(hsp,y)         ;%设计4入、单出线性网络
w=net.iw{1,1}               %观测估计参数（权值、阈值）
b=net.b{1}              
yi=sim(net,hsp)            ;%由DTNN输入u1(k),求辨识器输出yi(k)

figure(3);
plot(yi,'r');ylabel('辨识器输出yi(k)','color','r','fontsize',13);
             xlabel('(c)    k'),pause
figure(4);
E=zeros(1,90);
for k=1:90
    E(k)=0.5*(y(k)-yi(k))^2;
end
plot(E);ylabel('E(k)=e(k)^2/2','color','r','fontsize',13);
        xlabel('(e)    k'),pause


