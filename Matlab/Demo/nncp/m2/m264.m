%m264.m      RBFNNӦ�ã���XOR���⣬�ú���net=newrbe(u,d)
%            ����newrbe��scȱʡ��Ϊsc=1
clear all;
close all;

u=[0 0 1 1;0 1 0 1]  ;%XOR����������������� 
d=[0 1 1 0] ;               
net=newrbe(u,d)      ;%���������������������RBF����
y=sim(net,u);         %�۲��������
e=d-y                 %�۲�����������
w1=net.iw{1,1}        %�۲��������
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2} 
d
y
