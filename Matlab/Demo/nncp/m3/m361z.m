%m361z.m  2������ϵͳ��ģ�ͱ�ʶ��
%         ����ϵͳy(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%         ��ģ�ͱ�ʶ���ã�����DTNN
%         ���������߱�ʶ
clear all;
close all;

%----��ʼ����
K=500;
V=zeros(4,1);
V1=zeros(4,K);
y=zeros(K,1);E=y;e=y;ui=y;
u0=rand(K/10,1)-0.5;          
u=[u0;u0;u0;u0;u0;u0;u0;u0;u0;u0]               ;%ϵͳ����
a=0.55                                          ;%ѵ������

for k=3:K
    y(k)=1.5*y(k-1)-0.7*y(k-2)+u(k-1)+0.5*u(k-2) ;%ϵͳ���
    hsp=[y(k) y(k-1) y(k-2) u(k-2)]'             ;%������Ԫ����
    ui(k-1)=V'*hsp                               ;%���ʶ�����
    e(k-1)=u(k-1)-ui(k-1)                        ;%��ʶ���
    E(k-1)=(1/2)*e(k-1)^2                        ;%Ŀ�꺯��
    b=(hsp'*hsp)^0.5;
    V=V+a*e(k-1)*hsp/b                  ;%���Ʋ�����Ȩϵֵ������                 ��������
    V1(:,k)=V;             
end

figure;
subplot(311),plot(u,'r');ylabel('ϵͳ����u');
subplot(312),plot(y);ylabel('ϵͳ���y');
subplot(313),plot(ui,'b');ylabel('���ʶ�����ui');
             xlabel('k'),pause
figure(2);
subplot(221),plot(u,'r');hold on;plot(ui,'b');
             ylabel('ϵͳ����u    ���ʶ�����ui');xlabel('k');
subplot(223),plot(y);ylabel('ϵͳ���y');
subplot(222),plot(E,'b');ylabel('Ŀ�꺯��E(k)');
k=1:K;
subplot(224),plot(V1(1,k),'b');hold on;plot(V1(2,k),'r');hold on;
             plot(V1(3,k),'k');hold on;plot(V1(4,k),'b');
             ylabel('���Ʋ�����������V');xlabel('k'),pause

V