%m263b.m                  ������˹RBFNN(2)�����������������
clear all;
close all;

u=-3:3;
d=radbas(u)*1.2;
sc=1;
net=newrbe(u,d,sc)        ;%����RBFNN
y=sim(net,u)              ;%RBFNN�����
w1=net.iw{1,1}             %�۲�����Ȩϵֵ           
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2}
y=sim(net,u);
d
y