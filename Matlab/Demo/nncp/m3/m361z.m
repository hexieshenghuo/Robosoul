%m361z.m  2阶线性系统逆模型辨识：
%         仿真系统y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%         逆模型辨识器用：线性DTNN
%         适用于在线辨识
clear all;
close all;

%----初始设置
K=500;
V=zeros(4,1);
V1=zeros(4,K);
y=zeros(K,1);E=y;e=y;ui=y;
u0=rand(K/10,1)-0.5;          
u=[u0;u0;u0;u0;u0;u0;u0;u0;u0;u0]               ;%系统输入
a=0.55                                          ;%训练步长

for k=3:K
    y(k)=1.5*y(k-1)-0.7*y(k-2)+u(k-1)+0.5*u(k-2) ;%系统输出
    hsp=[y(k) y(k-1) y(k-2) u(k-2)]'             ;%构造神经元输入
    ui(k-1)=V'*hsp                               ;%逆辨识器输出
    e(k-1)=u(k-1)-ui(k-1)                        ;%辨识误差
    E(k-1)=(1/2)*e(k-1)^2                        ;%目标函数
    b=(hsp'*hsp)^0.5;
    V=V+a*e(k-1)*hsp/b                  ;%估计参数（权系值）调整                 　　　　
    V1(:,k)=V;             
end

figure;
subplot(311),plot(u,'r');ylabel('系统输入u');
subplot(312),plot(y);ylabel('系统输出y');
subplot(313),plot(ui,'b');ylabel('逆辨识器输出ui');
             xlabel('k'),pause
figure(2);
subplot(221),plot(u,'r');hold on;plot(ui,'b');
             ylabel('系统输入u    逆辨识器输出ui');xlabel('k');
subplot(223),plot(y);ylabel('系统输出y');
subplot(222),plot(E,'b');ylabel('目标函数E(k)');
k=1:K;
subplot(224),plot(V1(1,k),'b');hold on;plot(V1(2,k),'r');hold on;
             plot(V1(3,k),'k');hold on;plot(V1(4,k),'b');
             ylabel('估计参数调整过程V');xlabel('k'),pause

V