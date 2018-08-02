%m233b.m          构建2个神经元的单层感知器
clear all;
close all;

%----改变感知器的权值、阈值为随机数
net=newp([-2 2;-2 2],2)              ;%构建2输入、2输出单层感知器
w0=net.iw{1,1}                        %观测感知器的权值、阈值
b0=net.b{1}                                 
u=[-1;0];
y=sim(net,u)                          %观测感知器的输出 
net.inputweights{1,1}.initFcn='rands';%设感知器的权值、阈值为随机数
net.biases{1}.initFcn='rands';
net=init(net);
w=net.iw{1,1}                         %观测感知器的权值、阈值
b=net.b{1}                         
yy=sim(net,u)                         %改变权系值后，观测其输出   
