%ms2b2.m(m254.m)   BPNN��Ԫ��Simulinkģ�����--����
clear all;
close all;
u=-0.5:0.05:0.5        ;%����������
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u)         ;%����������������Ժ���d
net=newff(minmax(u),[3,1],{'tansig','purelin'},'trainlm');%N1,3,1
net=train(net,u,d);     
y=sim(net,u)                     ;%BPNN���
[d' y']
gensim(net,-1)                   ;%����
%gensim(net,0.5)                 ;%��ɢ
