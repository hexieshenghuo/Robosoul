%ms2b2.m(m254.m)   BPNN神经元的Simulink模型设计--连续
clear all;
close all;
u=-0.5:0.05:0.5        ;%输入样本集
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u)         ;%输出样本集：非线性函数d
net=newff(minmax(u),[3,1],{'tansig','purelin'},'trainlm');%N1,3,1
net=train(net,u,d);     
y=sim(net,u)                     ;%BPNN输出
[d' y']
gensim(net,-1)                   ;%连续
%gensim(net,0.5)                 ;%离散
