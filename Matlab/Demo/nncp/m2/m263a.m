%m263a.m           构建高斯RBFNN(1)：由输入输出样本集
clear all;
close all;

u=[1 2 3];
d=[2.0 4.0 5.9];
sc=1
%sc=5
%sc=10
net=newrbe(u,d,sc) ;%构建函数
w1=net.iw{1,1}      %观测网络权系值
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2}
y=sim(net,u) ;
d                 
y                  %观测网络输出
