%m441.m         神经自校正控制:
%               仿真对象 y(k)=0.8sin[y(k-1)]+1.2u(k-1) ,    k<200                                                                      
%                        y(k)=0.8sin[y(k-1)]+y(k-1)/7+1.2u(k-1),  k>=200                                       
clear all;
close all;

net=newff([-1 1],[10,1],{'tansig','purelin'}); %构建BPNN模型N1,10,1

%---初始设置
iw=(rand(10,1)-0.2)/10;
net.iw{1,1}=iw;
lw=net.lw{2,1};
i=100;
r1=ones(1,i);r2=-ones(1,2*i);r3=ones(1,i);
r=[r1 r2 r3];                               ;%设控制系统输入
v=zeros(1,4*i);v(50)=0.3                    ;%设扰动
 y=zeros(1,4*i);u=y;ng=y;
 e=y;e1=y;
 E=e;
 llw=zeros(4*i,1);llww=zeros(4*i,1);
 lww=zeros(10,10);
a=0.04                                      ;%训练步长

%---计算辨识器、控制器、系统的输出
 for k=2:4*i   
ya=y(k-1)                                   ;%辨识器输入
x=(net.iw{1,1}+net.b{1})*ya                 ;%辨识器隐层状态 
o=tansig(x)                                 ;%辨识器隐层输出 
ng=(net.lw{2,1}+net.b{2})*o ;
yi(k)=ng+1.2*u(k-1)                         ;%辨识器输出
u(k-1)=(r(k)-ng)/1.2;                       ;%控制器输出 
if (k<200 ),     
     y(k)=0.8*sin(y(k-1))+1.2*u(k-1)+v(k)   ;%控制系统输出
else y(k)=0.8*sin(y(k-1))+y(k-1)/7+1.2*u(k-1)+v(k);
   end 
       e1(k)=y(k)-yi(k);
       e(k)=r(k)-y(k);
       E(k)=e(k)^2/2                        ;%目标函数
       
%---辨识器训练
lw=net.lw{2,1}+a*e1(k)*o';
b2=net.b{2}+a*e1(k);
net.lw{2,1}=lw;
net.b{2}=b2;
for i=1:10
lww(i,i)=lw(1,i);
end
iw=net.iw{1,1}+a*e1(k)*lww*dtansig(x,o)*ya;
b1=net.b{1}+a*e1(k)*lww*dtansig(x,o);
net.iw{1,1}=iw;
net.b{1}=b1;
llw(k)=lw(1,1);
llww(k)=lw(1,2);
end

figure;
subplot(221),plot(y,'r');hold on;plot(r,'b');hold on;plot(v,'k');
                         ylabel('y    r    v');
                         title('控制系统输入r、输出y、扰动v');
subplot(223),plot(u,'b');ylabel('控制量u');xlabel('k');       
subplot(222),plot(E,'r');ylabel('目标函数E');
subplot(224),plot(llw,'r');hold on;plot(llww,'b');ylabel('部分权值调整过程 ');xlabel('k'); 