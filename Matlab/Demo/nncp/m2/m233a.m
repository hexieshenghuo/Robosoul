%m233a.m             构建1个神经元的单层感知器
clear all;
close all;

%---1.构建单输入、单输出单层感知器
net=newp([-2 2],1)     ;%设PR=[-2 2],S=1
w1=net.iw{1,1}          %观测构建的感知器1的权值、阈值
b1=net.b{1}             
u1=-1                  ;%感知器1的输入
y11=sim(net,u1)         %观测构建的感知器1的输出  
net.b{1}=[-1]          ;%设阈值
y12=sim(net,u1),pause   %改变阈值，观测输出

%---2.构建2输入、单输出单层感知器
net=newp([-2 2;-2 2],1);%PR=[;],S=1
w2=net.iw{1,1}          %观测构建的感知器2的权值、阈值
b2=net.b{1}               
u2=[-1;1]              ;%设感知器2的输入
y21=sim(net,u2)         %观测感知器2的输出  
net.b{1}=[-2]          ;%设阈值
y22=sim(net,u2),pause   %改变阈值，观测输出
