%m251b.m             ��(��ά)���������������Сֵ������BP����
clear all;
close all;

%---����BP����ṹ��N3,4,2
net=newff([0.5 1;0.3 0.9;1 2 ],[4,2],{'logsig','purelin'},'traingd') ;
w1=net.iw{1,1}                   %�۲�BP��1-2���Ȩֵ����ֵ
b1=net.b{1}                         
w2=net.lw{2,1}                   %�۲�2-3���Ȩֵ����ֵ
b2=net.b{2}                     
u=[1;0.5;1.2]                    %������
y=sim(net,u)                    %�۲���� 
