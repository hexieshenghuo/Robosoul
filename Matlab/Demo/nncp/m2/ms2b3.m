%ms2b3.m            RBFNN的Simulink模型设计-----离散
clear all;
close all;

%---输入、输出样本集
u=-0.5:0.05:1;            
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u);

eg=0.02              ;%设目标函数（均方差）
sc=0.2               ;%设散布(伸展)函数--较好
net=newrb(u,d,eg,sc) ;%设计网络
y=sim(net,u);        ;%网络输出
%gensim(net,-1)      ;%连续
gensim(net,0.5)      ;%离散
