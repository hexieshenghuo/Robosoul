% m352l.m      非线性动态系统辨识：
%              仿真系统：y(k)=0.8*sin(y(k-1))+1.2*u(k-1)                                     
%              辨识器：ElmanNN
%              适用于离线辨识
clear all;
close all;

%----初始设置
K=300;
y=zeros(1,K);
yi=zeros(1,K);

%----系统、辨识器输入                         
for k=1:K
   u(k)=0.6*sin(2*pi*k/60)-0.4*sin(2*pi*k/40);
end

figure(1);
plot(u,'b');ylabel('系统、辨识器输入u(k)','color','r','fontsize',13);
            xlabel(' k'),pause
   for k=2:K
  y(k)=0.8*sin(y(k-1))+1.2*u(k-1)           ;%系统1输出
   end   
   
figure(2);
plot(y,'m');ylabel('系统输出y(k)','color','r','fontsize',13);
            xlabel('k'),pause
            
net=newelm([-1 1],[3 1],{'tansig','purelin'},'trainlm');%设计ElmanNN
%iw=net.iw{1,1};
net=train(net,u,y);                                        
yi=sim(net,u)                                          ;%辨识器输出
figure(3);
plot(yi,'r');ylabel('辨识器输出yi(k)','color','r','fontsize',13');
             xlabel('k'),pause

for k=1:K
    E(k)=0.5*(y(k)-yi(k))^2                           ;%目标函数
end

figure(4);
plot(E,'b');ylabel('目标函数E(k)','color','r','fontsize',13');
            xlabel('k'),pause
figure(5);
plot(y,'b');hold on;plot(yi,'r');
            ylabel('系统输出y   辨识器输出yi','color','r','fontsize',13');
            xlabel('k'),pause
           


