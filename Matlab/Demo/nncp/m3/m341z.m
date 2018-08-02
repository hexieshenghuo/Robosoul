%m341z.m    2阶线性动态系统辨识：
%           仿真系统: y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%           线性DTNN(自适应线性神经元+TDL)应用
%           适用于在线辨识
clear all;
close all;

%----初始设置
i=90;
a=0.25               ;%训练步长
w=zeros(1,4);
w1=zeros(i,4);
yi=zeros(i,1);
e=yi;
E=yi;
u=prbs(4,90,4,3,0,0)  ;%系统、辨识器输入
num=[0 1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u);
z=[y u'];
figure(1);
idplot2(z,1:90),pause   ;%画系统、辨识器输入

%----系统辨识
for k=3:i
    hsp=[-y(k-1) -y(k-2) u(k-1) u(k-2)]' ; %构造神经元输入
    yi(k)=w*hsp                          ; %辨识器输出
    e(k)=y(k)-yi(k)                      ; %辨识误差
    E(k)=(1/2)*e(k)^2 ;
    b=(hsp'*hsp)^0.5;
    w=w+a*e(k)*hsp'/b                    ;%估计参数（权系值）调整
    w1(k,1:4)=w;                                                 
end

 figure(2);
plot(y);hold on;plot(yi,'m');
             ylabel('系统、辨识器输出 y(k)  yi(k)','color','r','fontsize',13) 
             xlabel('(b)    k'),pause             
figure(3) ;
plot(w1);axis([0 90 -2 1.2]);
         ylabel('估计参数调整过程 W(k)','color','r','fontsize',13);
         xlabel('(c)     k'),pause         
figure(4)                               ;%画目标函数
plot(E);ylabel('目标函数E(k)','color','r','fontsize',13);
        xlabel('(d)    k');        
 w=w1(90,:)                             %观测估计的参数

      
