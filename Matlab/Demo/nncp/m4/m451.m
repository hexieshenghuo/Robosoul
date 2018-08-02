%m451.m            神经PD控制:
%                  仿真对象 y(k)=0.8sin[y(k-1)]+1.2u(k-1)
clear all;
close all;

%----初始设置
i=80;
r=ones(i,1)                     ;%设单位阶跃输入
v=zeros(i,1);v(40,1)=0.1        ;%设扰动
y=zeros(i,1);u=y;ng=y;
e=y;e1=e;e2=e;
llw=zeros(i,1);
a1=0.1;                         ;%设训练步长
a2=0.08;

net=newff([-2 2],[10,1],{'tansig','purelin'})  ;%构建BP模型N1,10,1
iw=(rand(10,1)-0.5)/10                         ;%设置的初始权系值
net.iw{1,1}=iw;
lw=net.lw{2,1}/10;                                            
wpd=[0.6;0.3];                                 ;%PD控制器初始化 
dwpd=zeros(2,1);

%----PD控制系统
for k=2:i 
 e(k)=r(k)-y(k); 
 u(k)=wpd(1)*e(k)+wpd(2)*[e(k)-e(k-1)]+v(k)    ;%控制器输出    
 y(k)=0.8*sin(y(k-1))+1.2*u(k-1)+v(k)          ;%控制系统输出
    ya=y(k-1);                                 ;%辨识器输入
x=(net.iw{1,1}+net.b{1})*ya                    ;%辨识器隐层状态
o=tansig(x)                                    ;%辨识器隐层输出
ng=(net.lw{2,1}+net.b{2})*o                   ;
    yi(k)=ng+1.2*u(k-1)                       ;%辨识器输出yi(k)
       e1(k)=y(k)-yi(k)                       ;%辨识误差 
       
%----辨识器训练
lw=net.lw{2,1}+a2*e1(k)*o';
b2=net.b{2}+a2*e1(k);
net.lw{2,1}=lw;
net.b{2}=b2;
iw=net.iw{1,1}+a1*e1(k)*lw*dtansig(x,o)*ya;
net.iw{1,1}=iw;
b1=net.b{1}+a1*e1(k)*lw*dtansig(x,o);
net.b{1}=b1;
llw(k)=lw(1,1);

%----PD控制器训练
  e2(k)=r(k)-yi(k);
  dwpd=a1*1.2*e2(k)*[e(k);e(k)-e(k-1)];
  wpd=wpd+dwpd;      
   end
   
figure; 
subplot(221),plot(y,'r');hold on;plot(r,'b');hold on;
             plot(v,'k');axis([0 80 -0.2 2]);
                         ylabel('控制系统输入r、输出y');
             text(30,0.3,'扰动v(k)');
subplot(223),plot(u,'b');ylabel('控制器输出u'); xlabel('k');        
subplot(222),plot(y,'r');hold on;
             plot(yi,'b--');ylabel('系统、辨识器输出:y  yi');
subplot(224),plot(llw,'r');ylabel('一权值调整过程lw(1)');
                            xlabel('k');
