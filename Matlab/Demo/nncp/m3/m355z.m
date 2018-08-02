%m355z.m   非线性系统辨识:仿真系统y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3;
%          适用于在线辨识
%          x/q: 隐层节点第k点的状态向量/输出向量
%          x00/q00: 隐层节点第k-1点的状态向量/输出向量
clear all;
close all;

%----初始设置;
K=600;
x3=0;q2=0;
x00=zeros(3,1);q00=zeros(3,1);
q=zeros(3,1);
lww=zeros(K,1);iww=zeros(K,1);
iw=rand(3,2)/20       ;%随机设输入层至隐层的权系值
lw=rand(1,3)/20      ;%随机设隐层至输出层的权系值
u=zeros(K,1);y=u;yi=u;
e=u;
E=u;
dw=zeros(3,2);
  a1=0.15            ;%训练步长
  a2=0.08           ;
  
%----系统的输入u(k)、输出y(k)
for k=2:K
  u(k-1)=0.6*sin(2*pi*(k-1)/30)-0.4*sin(2*pi*(k-1)/60);
  y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3;
    
%-----PIDNN由输入u(k-1)、y(k-1)  至  隐层输出g  
  uy=[u(k-1);y(k-1)]        ;%PIDNN输入
x=iw*uy                     ;%隐层节点状态向量
%----比例
 q(1)=satlins(x(1));

%----积分
 q(2)=q2+x(2);
if (q(2)<-1), q(2)=-1 ;                   
elseif (q(2)>=1), q(2)=1;  
 end
    q2=q(2); 
%----微分 
     q(3)=x(3)-x3                       ;
   if  (q(3)<-1), q(3)=-1;
   elseif  q(3)>=1,q(3)=1; 
   end   
  x3=x(3); 
%----隐层输出q 至 PIDNN输出yi
    y1=lw*q                ;%输出节点为线性
    yi(k)=y1;
%----调整lw
  e(k)=y(k)-yi(k);
  E(k)=e(k)^2/2;
lw=lw+a2*e(k)*q';
 lww(k)=lw(1,1);
%----调整iw 
   h=sign((q-q00)./(x-x00));  
dw(1,:)=a1*e(k)*q(1)*h(1)*uy';
dw(2,:)=a1*e(k)*q(2)*h(2)*uy';
dw(3,:)=a1*e(k)*q(3)*h(3)*uy';
 iw=iw+dw;
 iww(k)=iw(1,1);
q00=q;
x00=x;
end

figure(1);
subplot(221),plot(u,'b');ylabel('输入u');
subplot(223),plot(y,'b');hold on;plot(yi,'r');
             ylabel('系统输出y  辨识器输出yi');xlabel(' k');
subplot(222),plot(E,'r');ylabel('目标函数E');
subplot(224),plot(iww,'b');hold on;plot(lww,'r');
             ylabel('w');xlabel('k');
             title('部分估计参数调整过程')
w1=iw
q
w2=lw