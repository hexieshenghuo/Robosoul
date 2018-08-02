%ms2b1.m(m242.m)    线性神经元的Simulink模型设计-----连续
clear all;
close all;

%----输入、输出样本集
u=[1 2 3 4 5];
d=[2.0  4.1 5.9  8.2  9.9];

net=newlind(u,d)  ;%线性神经元模型设计
y=sim(net,u)      ;%仿真 
w1=net.iw{1,1}     %观测权系值
b1=net.b{1}
gensim(net,-1)     ;%连续                 
%gensim(net,0.5)   ;%离散
