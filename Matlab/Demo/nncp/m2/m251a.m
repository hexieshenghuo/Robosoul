%m251a.m         由(二维)输入向量的最大、最小值，构建BP网络
clear all;
close all;

%----构建BP网络结构：N2,3,1
net=newff([-1 2;0 5],[3,1],{'tansig','purelin'},'traingd');
w1=net.iw{1,1}                   %观测BP网1-2层的权值、阈值
b1=net.b{1}                         
w2=net.lw{2,1}                   %观测2-3层的权值、阈值
b2=net.b{2}                     
u=[1;2]                          %设输入
y=sim(net,u) ,pause              %观测输出  
    
