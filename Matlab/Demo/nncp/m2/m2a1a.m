%m2a1a.m             ����2��Ԫ��CHNN������������̬       
clear all;
close all;

%---1. ����������䣨������̬����ȡȨϵֵ��
v=[1 -1; -1 1]             ;%2ά�ռ�������̬
net=newhop(v)              ;%������磬���Ȩϵֵ
w=net.lw{1,1}               %�۲���ȡ��Ȩϵֵ
b=net.b{1,1}
ai=v; 
y=sim(net,2,[],ai); %���鹹�������磬��������������� 
v
y

%---2.�����Ż����㣨Ȩϵֵ��֪���������̬Ѱ����̬��
a1={rands(2,1)};                   %��������һ�㣨��̬��
[y1,pf,af]=sim(net,{1 20},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1) ;               %cell2mat(a1)������
figure(1);                   
plot(v(1,:),v(2,:),'r*');axis([-1.1 1.1 -1.1 1.1]);
                         hold on,pause ;%�������ȶ�ƽ���
plot(start(1,1),start(2,1),'bo'),pause    ;%�������һ��    
plot(record(1,:),record(2,:));
                 title('��̬��o�㣩��������̬�Ĺ��� '),pause%����������
