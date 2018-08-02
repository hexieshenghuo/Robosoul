%m343z.m    ����ϵͳ������ʶ��
%           ����ϵͳ x(k+1)=Ax(k)+Bu(k)
%                    A=[0.368 0;0.632 1] ,
%                    B=[0.632;0.368] 
%           ���������߱�ʶ
clear all;
close all;

%----��ʼ����
i=100;
x=zeros(2,i+1);
A=[0.368 0;0.632 1];
B=[0.632;0.368];
w=zeros(6,6);
I=zeros(i,6);
V=zeros(6,i);
x(:,1)=[0;0];
a=0.5;
K=3;

for k=1:i-1
  %----1.����:������u(k),�����x(k+1)=Ax(k)+Bu(k)
    u(k)=0.4*sin(k);
   x(:,k+1)=A*x(:,k)+B*u(k);       
%----2.��{u(k),x(k)}������Ȩϵֵw��ƫ��I   
w=-[x(1,k)^2 x(1,k)*x(2,k) 0 0 x(1,k)*u(k) 0;
   x(1,k)*x(2,k) x(2,k)^2 0 0 x(2,k)*u(k) 0;
   0 0 x(1,k)^2 x(1,k)*x(2,k) 0 x(1,k)*u(k);
   0 0 x(1,k)*x(2,k) x(2,k)^2 0 x(2,k)*u(k);
   x(1,k)*u(k) x(2,k)*u(k) 0 0 u(k)^2 0;
   0 0 x(1,k)*u(k) x(2,k)*u(k) 0 u(k)^2];                           %��Ȩϵֵ
I=[x(1,k+1)*x(:,k)' x(2,k+1)*x(:,k)' x(1,k+1)*u(k) x(2,k+1)*u(k)]; %��ƫ�ã���ֵ��
%----3.�����������ƽ���Ϊ����Ĺ��Ʋ���
V(1,k+1)=V(1,k)+a*(w(1,:)*V(:,k)+I(1))*(K^2-V(1,k)^2);
V(2,k+1)=V(2,k)+a*(w(2,:)*V(:,k)+I(2))*(K^2-V(2,k)^2);
V(3,k+1)=V(3,k)+a*(w(3,:)*V(:,k)+I(3))*(K^2-V(3,k)^2);
V(4,k+1)=V(4,k)+a*(w(4,:)*V(:,k)+I(4))*(K^2-V(4,k)^2);
V(5,k+1)=V(5,k)+a*(w(5,:)*V(:,k)+I(5))*(K^2-V(5,k)^2);
V(6,k+1)=V(6,k)+a*(w(6,:)*V(:,k)+I(6))*(K^2-V(6,k)^2);
end 

figure(1);    
subplot(311),plot(u,'b');title('ϵͳ����u(k)��״̬x(k)');ylabel('u(k)');
subplot(312),plot(x(1,1:i),'r');ylabel('x1(k)');
subplot(313),plot(x(2,1:i),'r');ylabel('x2(k)');xlabel('k'),pause
figure(2);
k=1:i-1;
subplot(321),plot(k,V(1,k),'b');ylabel('V1(k)');title('�������ƹ���');
subplot(322),plot(k,V(2,k),'b');ylabel('V2(k)');
subplot(323),plot(k,V(3,k),'b');ylabel('V3(k)');
subplot(324),plot(k,V(4,k),'b');ylabel('V4(k)');
subplot(325),plot(k,V(5,k),'r');ylabel('V5(k)');xlabel('k');
subplot(326),plot(k,V(6,k),'r');ylabel('V6(k)');xlabel('k'),pause
V=V(:,100)'                     %�۲���ƵĲ���
