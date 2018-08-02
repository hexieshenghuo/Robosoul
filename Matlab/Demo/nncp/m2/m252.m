%m252.m             构造BP网络、训练网络
clear all;
close all;

u=[-1 -1 2 2;0 5 0 5];
d=[-1 -1 1 1];
net=newff(minmax(u),[3,1],{'tansig','purelin'},'traingd');%构建N2,3,1
%w01=net.iw{1,1}                   %观测BP网1-2层的初始权值
%b01=net.b{1}                      %观测           初始阈值
%w02=net.lw{2}                     %观测2-3层的权值
%b02=net.b{2}                      %观测       阈值           
figure(1);
net=train(net,u,d);
w1=net.iw{1,1}                    %观测BP学习后的权系值
b1=net.b{1}                      
w2=net.lw{2}                     
b2=net.b{2}   
d                                 %观测
y=sim(net,u)                      

figure(2);
k=1:4;
plot(k,d,'go',k,y,'r*');

