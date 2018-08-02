%m265b.m                  仿真：由设计的高斯RBFNN1,7,1  逼近非线性函数d
clear all;
close all;

b2=-0.1408                                             ;%由m265a.m执行结果得到
u=-3:0.1:3;
g1=radbas((u-0.7)*0.8326);    g2=radbas((u+1.7)*0.8326);% 7个隐层节点的输出
g3=radbas((u-2.1)*0.8326);    g4=radbas((u+0.1)*0.8326);
g5=radbas((u-2.7)*0.8326);    g6=radbas((u+1.4)*0.8326);
g7=radbas((u-3.0)*0.8326);
g11=g1*0.0999;                g21=g2*1.7506;             % 7个隐层节点输出的加权
g31=g3*2.4990;                g41=g4*1.2114;
g51=g5*(-4.2798);             g61=g6*(-1.3976);
g71=g7*2.8588;
figure(1);
plot(u,g1,'b',u,g2,'b',u,g3,'b',u,g4,'b',u,g5,'b',u,g6,'b',u,g7,'b');axis([-3 3 -5 3]);
     text(-1.7,1.2,'1');text(-1.3,1.2,'2');text(0,1.2,'3');
     text(0.7,1.2,'4');text(2,1.2,'5');text(2.7,1.2,'6');text(2.9,1.2,'7');xlabel('u'),pause
y1=(g11+g21+g31+g41+g51+g61+g71)+b2;                     %RBFNN1,7,1的输出

figure(2);
plot(u,g11,'b',u,g21,'b',u,g31,'b',u,g41,'b',u,g51,'b',u,g61,'b',u,g71,'b');axis([-3 3 -5 3]);
     text(-1.7,2,'1');text(-1.3,-1.7,'2');text(0,1.5,'3');
     text(0.7,0.3,'4');text(2,2.7,'5');text(2.7,-4.5,'6');text(2.9,2.6,'7');hold on,pause
     plot(u,y1,'r');xlabel('u'),pause
figure(3);
plot(u,y1,'r*');ylabel('网络输出');xlabel('u'),pause

%---构造d
q1=radbas(u);
q2=radbas(u-1.5);
q3=radbas(u+2);
q31=0.5*q3;
d=q1+q2+q31;
figure(4);
plot(u,y1,'r*',u,d,'bo');ylabel('网络输出y1  非线性函数d');xlabel('u')
