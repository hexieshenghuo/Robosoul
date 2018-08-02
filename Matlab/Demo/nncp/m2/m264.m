%m264.m      RBFNN应用：解XOR问题，用函数net=newrbe(u,d)
%            函数newrbe中sc缺省，为sc=1
clear all;
close all;

u=[0 0 1 1;0 1 0 1]  ;%XOR问题输入输出样本集 
d=[0 1 1 0] ;               
net=newrbe(u,d)      ;%由输入输出样本集，构建RBF网络
y=sim(net,u);         %观测网络输出
e=d-y                 %观测网络输出误差
w1=net.iw{1,1}        %观测网络参数
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2} 
d
y
