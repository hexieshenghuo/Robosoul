%m251a.m         ��(��ά)���������������Сֵ������BP����
clear all;
close all;

%----����BP����ṹ��N2,3,1
net=newff([-1 2;0 5],[3,1],{'tansig','purelin'},'traingd');
w1=net.iw{1,1}                   %�۲�BP��1-2���Ȩֵ����ֵ
b1=net.b{1}                         
w2=net.lw{2,1}                   %�۲�2-3���Ȩֵ����ֵ
b2=net.b{2}                     
u=[1;2]                          %������
y=sim(net,u) ,pause              %�۲����  
    
