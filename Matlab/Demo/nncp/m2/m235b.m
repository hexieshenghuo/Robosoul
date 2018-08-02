%m235b.m  单层感知器(1个神经元)应用：三维空间模式分类 （线性可分集合）
clear all;
close all;

 %----输入、输出样本
p=[-1 +1 -1 +1 -1 +1 -1 +1; 
   -1 -1 +1 +1 -1 -1 +1 +1; 
   -1 -1 -1 -1 +1 +1 +1 +1];
d=[0 1 0 0 1 1 0 1];
  
figure(1);
plotpv(p,d),pause            %画两类输入样本
net=newp([-1 1;-1 1;-1 1],1);%由输入样本的最大、最小值构建单神经元感知器
net=train(net,p,d)          ;%感知器训练
w=net.iw{1,1}                %观测训练后的权系值
b=net.b{1}
figure(2);
plotpv(p,d);hold on;plotpc(w,b),pause %画输入样本、分类面 
y=sim(net,p) ;                         
d
y                            %观测在p输入下，感知器的输出

