%m371l.m    ������ϵͳ��ģ�ͱ�ʶ��
%           ����ϵͳ y(k)=0.8sin[y(k-1)]+1.2u(k-1)
%           ���ʶ����:������DTNN(RBFNN + ʱ�ӻ���)
%           ���߱�ʶ
clear all;
close all;

%---��ʼ����
K=150;
eg=0.2                ;%��Ŀ�꺯�������������
sc=1                  ;%��ɢ��(��չ)����
y=zeros(1,K);
y1=y;
u1=y;

u=rand(1,K)-0.5;        %ϵͳ����
  for k=2:K;
  y(k)=0.8*sin(y(k-1))+1.2*u(k-1);%ϵͳ���
 end

for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
 hsp=[y;y1]                 ;%RBFNN����������
net=newrb(hsp,u1,eg,sc)     ;%�������
ui=sim(net,hsp);            ;%��ʶ�����
E=zeros(1,K);
for k=1:K
    E(k)=0.5*(u1(k)-ui(k))^2;
end

figure;
subplot(221),plot(u,'b');ylabel('ϵͳ����u');
subplot(223),plot(y,'b');ylabel('ϵͳ���y');xlabel('k');
subplot(222),plot(ui,'r');ylabel('��ģ�ͱ�ʶ�����ui ');
subplot(224),plot(E);ylabel('Ŀ�꺯��E(k)');xlabel('k');
w1=net.iw{1}            %�۲���ƣ����磩����
b1=net.b{1}
w2=net.lw{2}
b2=net.b{2}


