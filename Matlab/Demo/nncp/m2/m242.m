%m242.m         线性神经元应用：函数(L2)逼近
clear all;
close all;

u=[1 2 3 4 5]               ; %已知期望输入
d=[2.0 4.3 5.7 8.2 9.5]     ; %        输出
net=newlind(u,d)            ; %设计线性神经元
y=sim(net,u)                ; %仿真:由输入u,求神经元输出y

figure(1);
plot(u,d,'b*');ylabel('d');xlabel('u');
               text(2,9,'d/u (*) 已知期望输入、输出'),pause
figure(2);
plot(u,d,'b*',u,y,'r+');ylabel('d      y');xlabel('u');
               text(2,9,'d/u (*) 已知期望输入、输出');
               text(3,3,'y/u (+)  线性神经元输入、输出 '),pause  
figure(3);
plot(u,d,'b*',u,y,'r+',u,y,'r--');ylabel('d      y');xlabel('u');
              text(2,9,'d/u (*) 已知期望输入、输出');
              text(3,3,'y/u (+)  线性神经元输入、输出 '),pause      
w=net.iw{1,1}                 %观测权值、阈值
b=net.b{1}                                              
w=-2:0.2:2;
b=-2:0.2:2;
es=errsurf(u,d,w,b,'purelin');
figure(4);
plotes(w,b,es) ,text(-4.3,2.2,'误差曲面及等高线');
