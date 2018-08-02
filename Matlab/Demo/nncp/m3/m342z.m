%m342z.m    2阶线性动态系统辨识：仿真系统y(k)+0.2y(k-1)=0.5u(k-1)
%           线性DTNN(自适应线性神经元+TDL)应用
%           适用于在线辨识
clear all;
close all;

%----初始设置
K=90;
a=0.25               ;%训练步长
w=zeros(1,2);
w1=zeros(K,2);
yi=zeros(K,1);
v=(rand(K,1)-0.5)/20 ;%噪声
e=yi;
E=yi;

u=prbs(4,K,4,3,0,0) ;%系统、辨识器输入
num=[0 0.5];
den=[1 0.2];
y=dlsim(num,den,u);
z1=[y u'];
figure(1);
idplot2(z1,1:K),pause ;%画系统、辨识器输入

%----系统辨识
for k=2:K
    z(k)=y(k)+v(k);
    hsp=[-z(k-1) u(k-1)]'  ;%构造神经元输入
    yi(k)=w*hsp            ;%辨识器输出
    e(k)=z(k)-yi(k)        ;%辨识误差
    E(k)=(1/2)*e(k)^2 ;
    b=(hsp'*hsp)^0.5;
    w=w+a*e(k)*hsp'/b      ;%估计参数（权系值）调整
    w1(k,1:2)=w;                                                 
end

 figure(2);
plot(y);hold on;plot(yi,'m');
        title('有噪声的系统输出z(k)、辨识器输出yi(k)','color','r');
        xlabel('(b)    k'),pause
figure(3) ;
plot(w1);ylabel('估计参数调整过程 W(k)','color','r','fontsize',13);
         xlabel('(c)     k'),pause
            
figure(4);         
plot(E);ylabel('目标函数E(k)','color','r','fontsize',13);
        xlabel('(d)    k');
 w1(90,:)                   %观测估计的参数

      
