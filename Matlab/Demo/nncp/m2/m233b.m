%m233b.m          ����2����Ԫ�ĵ����֪��
clear all;
close all;

%----�ı��֪����Ȩֵ����ֵΪ�����
net=newp([-2 2;-2 2],2)              ;%����2���롢2��������֪��
w0=net.iw{1,1}                        %�۲��֪����Ȩֵ����ֵ
b0=net.b{1}                                 
u=[-1;0];
y=sim(net,u)                          %�۲��֪������� 
net.inputweights{1,1}.initFcn='rands';%���֪����Ȩֵ����ֵΪ�����
net.biases{1}.initFcn='rands';
net=init(net);
w=net.iw{1,1}                         %�۲��֪����Ȩֵ����ֵ
b=net.b{1}                         
yy=sim(net,u)                         %�ı�Ȩϵֵ�󣬹۲������   
