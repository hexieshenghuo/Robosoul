%m263b.m                  构建高斯RBFNN(2)：由输入输出样本集
clear all;
close all;

u=-3:3;
d=radbas(u)*1.2;
sc=1;
net=newrbe(u,d,sc)        ;%构建RBFNN
y=sim(net,u)              ;%RBFNN的输出
w1=net.iw{1,1}             %观测网络权系值           
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2}
y=sim(net,u);
d
y