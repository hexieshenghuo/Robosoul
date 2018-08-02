% m352l.m      �����Զ�̬ϵͳ��ʶ��
%              ����ϵͳ��y(k)=0.8*sin(y(k-1))+1.2*u(k-1)                                     
%              ��ʶ����ElmanNN
%              ���������߱�ʶ
clear all;
close all;

%----��ʼ����
K=300;
y=zeros(1,K);
yi=zeros(1,K);

%----ϵͳ����ʶ������                         
for k=1:K
   u(k)=0.6*sin(2*pi*k/60)-0.4*sin(2*pi*k/40);
end

figure(1);
plot(u,'b');ylabel('ϵͳ����ʶ������u(k)','color','r','fontsize',13);
            xlabel(' k'),pause
   for k=2:K
  y(k)=0.8*sin(y(k-1))+1.2*u(k-1)           ;%ϵͳ1���
   end   
   
figure(2);
plot(y,'m');ylabel('ϵͳ���y(k)','color','r','fontsize',13);
            xlabel('k'),pause
            
net=newelm([-1 1],[3 1],{'tansig','purelin'},'trainlm');%���ElmanNN
%iw=net.iw{1,1};
net=train(net,u,y);                                        
yi=sim(net,u)                                          ;%��ʶ�����
figure(3);
plot(yi,'r');ylabel('��ʶ�����yi(k)','color','r','fontsize',13');
             xlabel('k'),pause

for k=1:K
    E(k)=0.5*(y(k)-yi(k))^2                           ;%Ŀ�꺯��
end

figure(4);
plot(E,'b');ylabel('Ŀ�꺯��E(k)','color','r','fontsize',13');
            xlabel('k'),pause
figure(5);
plot(y,'b');hold on;plot(yi,'r');
            ylabel('ϵͳ���y   ��ʶ�����yi','color','r','fontsize',13');
            xlabel('k'),pause
           


