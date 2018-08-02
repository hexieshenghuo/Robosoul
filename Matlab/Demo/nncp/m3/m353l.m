%m353l.m     �����Զ�̬ϵͳ��ʶ��
%            ����ϵͳ y(k)=5y(k-1)/(2.5+y^2(k-1))+u^3(k-1)
%            ��ʶ����:������DTNN(RBFNN + ʱ�ӻ���)
%            ���������߱�ʶ
clear all;
close all;

%----��ʼ����
K=150;
y=zeros(1,K); 
y1=y;
u=y;
u1=y;
E=y;
eg=0.2             ;%��Ŀ�꺯��
sc=1               ;%��ɢ��(��չ)ϵ��

%----ϵͳ���롢���
  for k=2:K;
  u(k)=0.6*cos(2*pi*k/70)-0.4*cos(2*pi*k/40);%ϵͳ����
  y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3     ;%ϵͳ���
 end
 
for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
hsp=[y1;u1];                     ;%RBFNN����������
net=newrb(hsp,y,eg,sc)           ;%��Ʊ�ʶ�������磩
yi=sim(net,hsp);                 ;%��ʶ�����

for k=1:K
    E(k)=0.5*(y(k)-yi(k))^2;
end

figure;
subplot(221),plot(u,'b');ylabel('ϵͳ����ʶ������u');
subplot(223),plot(y,'m');ylabel('ϵͳ���y ');xlabel('k');
subplot(222),plot(yi,'r');ylabel('��ʶ�����yi');
subplot(224),plot(E);ylabel('E(k)=e(k)^2/2');xlabel('k');
w1=net.iw{1}            %�۲��ʶ�������ƣ�����
b1=net.b{1}
w2=net.lw{2}
b2=net.b{2}