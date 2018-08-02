%m2a1a.m             构建2神经元的CHNN：给定两个稳态       
clear all;
close all;

%---1. 用于联想记忆（给定稳态，求取权系值）
v=[1 -1; -1 1]             ;%2维空间两个稳态
net=newhop(v)              ;%设计网络，求得权系值
w=net.lw{1,1}               %观测求取的权系值
b=net.b{1,1}
ai=v; 
y=sim(net,2,[],ai); %检验构建的网络，具有联想记忆能力 
v
y

%---2.用于优化计算（权系值已知，由任意初态寻找稳态）
a1={rands(2,1)};                   %随机输入的一点（初态）
[y1,pf,af]=sim(net,{1 20},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1) ;               %cell2mat(a1)的作用
figure(1);                   
plot(v(1,:),v(2,:),'r*');axis([-1.1 1.1 -1.1 1.1]);
                         hold on,pause ;%画两个稳定平衡点
plot(start(1,1),start(2,1),'bo'),pause    ;%画输入的一点    
plot(record(1,:),record(2,:));
                 title('初态（o点）收敛于稳态的过程 '),pause%画收敛过程
