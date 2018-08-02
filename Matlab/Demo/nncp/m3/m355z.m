%m355z.m   ������ϵͳ��ʶ:����ϵͳy(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3;
%          ���������߱�ʶ
%          x/q: ����ڵ��k���״̬����/�������
%          x00/q00: ����ڵ��k-1���״̬����/�������
clear all;
close all;

%----��ʼ����;
K=600;
x3=0;q2=0;
x00=zeros(3,1);q00=zeros(3,1);
q=zeros(3,1);
lww=zeros(K,1);iww=zeros(K,1);
iw=rand(3,2)/20       ;%�����������������Ȩϵֵ
lw=rand(1,3)/20      ;%�����������������Ȩϵֵ
u=zeros(K,1);y=u;yi=u;
e=u;
E=u;
dw=zeros(3,2);
  a1=0.15            ;%ѵ������
  a2=0.08           ;
  
%----ϵͳ������u(k)�����y(k)
for k=2:K
  u(k-1)=0.6*sin(2*pi*(k-1)/30)-0.4*sin(2*pi*(k-1)/60);
  y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3;
    
%-----PIDNN������u(k-1)��y(k-1)  ��  �������g  
  uy=[u(k-1);y(k-1)]        ;%PIDNN����
x=iw*uy                     ;%����ڵ�״̬����
%----����
 q(1)=satlins(x(1));

%----����
 q(2)=q2+x(2);
if (q(2)<-1), q(2)=-1 ;                   
elseif (q(2)>=1), q(2)=1;  
 end
    q2=q(2); 
%----΢�� 
     q(3)=x(3)-x3                       ;
   if  (q(3)<-1), q(3)=-1;
   elseif  q(3)>=1,q(3)=1; 
   end   
  x3=x(3); 
%----�������q �� PIDNN���yi
    y1=lw*q                ;%����ڵ�Ϊ����
    yi(k)=y1;
%----����lw
  e(k)=y(k)-yi(k);
  E(k)=e(k)^2/2;
lw=lw+a2*e(k)*q';
 lww(k)=lw(1,1);
%----����iw 
   h=sign((q-q00)./(x-x00));  
dw(1,:)=a1*e(k)*q(1)*h(1)*uy';
dw(2,:)=a1*e(k)*q(2)*h(2)*uy';
dw(3,:)=a1*e(k)*q(3)*h(3)*uy';
 iw=iw+dw;
 iww(k)=iw(1,1);
q00=q;
x00=x;
end

figure(1);
subplot(221),plot(u,'b');ylabel('����u');
subplot(223),plot(y,'b');hold on;plot(yi,'r');
             ylabel('ϵͳ���y  ��ʶ�����yi');xlabel(' k');
subplot(222),plot(E,'r');ylabel('Ŀ�꺯��E');
subplot(224),plot(iww,'b');hold on;plot(lww,'r');
             ylabel('w');xlabel('k');
             title('���ֹ��Ʋ�����������')
w1=iw
q
w2=lw