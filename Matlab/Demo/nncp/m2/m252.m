%m252.m             ����BP���硢ѵ������
clear all;
close all;

u=[-1 -1 2 2;0 5 0 5];
d=[-1 -1 1 1];
net=newff(minmax(u),[3,1],{'tansig','purelin'},'traingd');%����N2,3,1
%w01=net.iw{1,1}                   %�۲�BP��1-2��ĳ�ʼȨֵ
%b01=net.b{1}                      %�۲�           ��ʼ��ֵ
%w02=net.lw{2}                     %�۲�2-3���Ȩֵ
%b02=net.b{2}                      %�۲�       ��ֵ           
figure(1);
net=train(net,u,d);
w1=net.iw{1,1}                    %�۲�BPѧϰ���Ȩϵֵ
b1=net.b{1}                      
w2=net.lw{2}                     
b2=net.b{2}   
d                                 %�۲�
y=sim(net,u)                      

figure(2);
k=1:4;
plot(k,d,'go',k,y,'r*');

