%ms2b1.m(m242.m)    ������Ԫ��Simulinkģ�����-----����
clear all;
close all;

%----���롢���������
u=[1 2 3 4 5];
d=[2.0  4.1 5.9  8.2  9.9];

net=newlind(u,d)  ;%������Ԫģ�����
y=sim(net,u)      ;%���� 
w1=net.iw{1,1}     %�۲�Ȩϵֵ
b1=net.b{1}
gensim(net,-1)     ;%����                 
%gensim(net,0.5)   ;%��ɢ
