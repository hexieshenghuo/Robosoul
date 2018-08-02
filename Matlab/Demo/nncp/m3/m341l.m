%m341l.m    2�����Զ�̬ϵͳ��ʶ��
%           ����ϵͳ: y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%           ����DTNN(����Ӧ������Ԫ+TDL)Ӧ��
%           ���������߱�ʶ
clear all;
close all;

%---��ʼ����
K=90;
y1=zeros(1,K);
y2=y1;
u1=y1;
u2=y1;

u=prbs(4,K,4,3,0,0)'           ;%ϵͳ����ʶ������
num=[1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u)              ;%ϵͳ���
z=[y u];
figure(1);
idplot2(z,1:K)                  ;%��ϵͳ���
figure(2);
plot(y,'m');ylabel('ϵͳ���y(k)','color','r','fontsize',13);
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

hsp=[-y1;-y2;u1;u2]        ;%������Ԫ����
net=newlind(hsp,y)         ;%���4�롢������������
w=net.iw{1,1}               %�۲���Ʋ�����Ȩֵ����ֵ��
b=net.b{1}              
yi=sim(net,hsp)            ;%��DTNN����u1(k),���ʶ�����yi(k)

figure(3);
plot(yi,'r');ylabel('��ʶ�����yi(k)','color','r','fontsize',13);
             xlabel('(c)    k'),pause
figure(4);
E=zeros(1,90);
for k=1:90
    E(k)=0.5*(y(k)-yi(k))^2;
end
plot(E);ylabel('E(k)=e(k)^2/2','color','r','fontsize',13);
        xlabel('(e)    k'),pause


