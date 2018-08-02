%m361l.m  2������ϵͳ��ģ�ͱ�ʶ��
%         ����ϵͳy(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%         ��ģ�ͱ�ʶ���ã�����DTNN
%         ���������߱�ʶ
clear all;
close all;

%---��ʼ����
K=90;
y1=zeros(1,K);
y2=y1;
u1=y1;
u2=y1;
hsp=zeros(4,K);

u=prbs(4,K,4,3,0,0)'     ;%ϵͳ����ʶ������;
num=[1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u);
z=[y u];
figure(1);
idplot2(z,1:K);ylabel('ϵͳ����u(k)','color','r','fontsize',13);
               xlabel('(a)    k'),pause
figure(2);
plot(y,'m');ylabel('ϵͳ�������ʶ������y(k)','color','r','fontsize',13);
                  xlabel('(b)    k'),pause
u=u';
y=y';
for k=1:K-1
    y1(k+1)=y(k);
    u1(k+1)=u(k);
end
for k=1:K-2
    y2(k+2)=y(k);
    u2(k+2)=u(k);
end
hsp=[y;y1;y2;u2];
net=newlind(hsp,u1)    ;%���4�롢����������Ԫ
V=net.iw{1,1};              %���Ʋ�����Ȩֵ����ֵ��
b=net.b{1} ;              
ui=sim(net,hsp)             ;%������y1(k),���ʶ�����ui(k)
z1=[y;ui]';

figure(3);
idplot2(z1,1:K);ylabel('��ģ�ͱ�ʶ�����ui(k)','color','r','fontsize',13);
                 xlabel('(c)    k'),pause
figure(4);
for k=1:K
    E(k)=(u1(k)-ui(k))^2/2;
end
plot(E,'b');ylabel('Ŀ�꺯��E(k)','color','r','fontsize',13);
                               xlabel('(d)    k'),pause

V=V'
b