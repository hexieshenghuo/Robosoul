%ms2b3.m            RBFNN��Simulinkģ�����-----��ɢ
clear all;
close all;

%---���롢���������
u=-0.5:0.05:1;            
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u);

eg=0.02              ;%��Ŀ�꺯���������
sc=0.2               ;%��ɢ��(��չ)����--�Ϻ�
net=newrb(u,d,eg,sc) ;%�������
y=sim(net,u);        ;%�������
%gensim(net,-1)      ;%����
gensim(net,0.5)      ;%��ɢ
