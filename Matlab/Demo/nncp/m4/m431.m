%m431.m    PI�������Ż���ƣ�
%          ����ϵͳ(����) x(k+1)=Ax(k)+Bu(k) , y(k)=Cx(k)
%             A=[0.368 0;0.632 1] ,B=[0.632;0.368] ,C=[0 1]  
clear all;
close all;

%---��ʼ����
i=100;
x=zeros(2,i+1);
A=[0.368 0;0.632 1];
B=[0.632;0.368];
C=[0 1];
w=zeros(2,2);
I=zeros(i,2);
V=zeros(2,i);
y=zeros(i,1);
e=y;
ee=zeros(i,1);
x(:,1)=[0;0];
r=1;
a1=0.15;
a2=0.02;
K=2;
ee(1)=e(1);

for k=2:i-1
%---1.����:������r(k),PI����,�����y(k)
  e(k)=r-y(k);
  ee(k)=ee(k-1)+e(k);
  u(k)=V(1,k)*e(k)+V(2,k)*ee(k);  
  x(:,k+1)=A*x(:,k)+B*u(k); 
  y(k+1)=C*x(:,k+1); 
%---2.������Ȩϵֵw��ƫ��(��ֵ)I 
w=-[(C*B*e(k))*(C*B*e(k)) 2*(C*B*ee(k))*(C*B*e(k));
    2*(C*B*ee(k))*(C*B*e(k)) (C*B*ee(k))*(C*B*ee(k))]       ;%��Ȩϵֵ
I=[2*(C*B*e(k))*(1-(C*A*x(k))) 2*(C*B*ee(k))*(1-(C*A*x(k)))];%��ƫ�ã���ֵ��
%----3.Kp��Ki�Ż�����
V(1,k+1)=V(1,k)+a1*(w(1,:)*V(:,k)+I(1))*(K^2-V(1,k)^2)      ;%Kp�Ż�����
V(2,k+1)=V(2,k)+a2*(w(2,:)*V(:,k)+I(2))*(K^2-V(2,k)^2)      ;%Ki�Ż�����
end

figure(1);  
k=1:i-1;
subplot(211),plot(k,V(1,k),'b');ylabel('Kp(k)');
             xlabel('k');title('Kp  Ki�����Ż�����');
subplot(212),plot(k,V(2,k),'b');ylabel('Ki(k)');xlabel('k'),pause
figure(2);  %���Ż������п���ϵͳ���롢�����������
k=1:i;
subplot(211),plot(k,r,'b');hold on;plot(x(2,1:100),'r');
             ylabel('r(k)   y(k)');xlabel('k');
             title('Kp  Ki�Ż������п���ϵͳ���롢�����������');
subplot(212),plot(u,'r');ylabel('u(k)');xlabel('k'),pause

y=zeros(i,1);
e=zeros(i,1);
ee=zeros(i,1);
x(:,1)=[0;0];

 %----���Ż��˵�Kp��Ki�������棬ʵ�ֽ�Ծ�����µ�PI����
for k=2:i-1
  e(k)=r-y(k);
    ee(k)=ee(k-1)+e(k);
    u(k)=V(1,100)*e(k)+V(2,100)*ee(k);  %u(k)=Kpe(k)+Kiee(k)
   x(:,k+1)=A*x(:,k)+B*u(k); 
   y(k+1)=C*x(:,k+1); 
end

figure(3); %�����Ż���PI�����ڿ���ϵͳ  
k=1:i;
subplot(211),plot(k,r,'b');hold on;plot(x(2,1:100),'r');
             ylabel('r(k)  y(k)');xlabel('(e)  k');
             title('���Ż���Kp��Ki��ʵ�ֽ�Ծ�����µ�PI����');
subplot(212),plot(u,'r');ylabel('���������u(k)');;xlabel('k')
Kp=V(1,100)     %�۲��Ż���PI����    
Ki=V(2,100)

figure(4);
k=1:100;
subplot(221),plot(k,V(1,k),'b');ylabel('Kp(k)');title('Kp  Ki�����Ż�����');
subplot(223),plot(k,V(2,k),'b');ylabel('Ki(k)');xlabel('k');
subplot(222),plot(k,r,'b');hold on;plot(x(2,1:100),'r');ylabel('r(k)  y(k)');
                           title('�Ż���Kp��Ki��ʵ�ֽ�Ծ�����µ�PI����');
subplot(224),plot(u,'r');ylabel('���������u(k)');;xlabel('k')