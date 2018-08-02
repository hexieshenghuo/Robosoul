%m472.m    ������������ϵͳ����: 
%          �������(ʱ��):y(k)=0.8sin(y(k-1))+1.2u(k-1),k<40
%                   y=sin(0.4y(k-1))+1.2u(k-1),   k>=40
%          PIDNN����
clear all;
close all;

%---��ʼ����
i=80;
x3=0;q2=0;
x00=zeros(3,1);q00=zeros(3,1);
q=zeros(3,1);
lww=zeros(i,1);iww=zeros(i,1);
iw=rand(3,2)/4               ;%�����������������Ȩϵֵ
lw=rand(1,3)/5               ;%��������������Ȩϵֵ���
u=zeros(i,1);y=u;
e=u;E=u;
r=ones(i,1);
p=zeros(3,3);
dw=zeros(3,2);                ;%�����ڶ����ϵĽ�Ծ�Ŷ�                       
  a1=0.2                      ;%ѵ������
  a2=0.1;
    
%----����ϵͳ����r(k)=1(k)�����y(k)
for k=2:i-1                  
  ry=[r(k);y(k)]              ;%PIDNN����
x=iw*ry                       ;%����ڵ�״̬����
%---����
 q(1)=satlins(x(1));
%---����
 q(2)=q2+x(2);
if (q(2)<-1), q(2)=-1 ;                   
elseif (q(2)>=1), q(2)=1;  
 end
    q2=q(2); 
 %---΢�� 
     q(3)=x(3)-x3 ;
   if  (q(3)<-1), q(3)=-1;
   elseif  q(3)>=1,q(3)=1; 
   end   
  x3=x(3);     
%----�������q �� PIDNN���yi
    u1=lw*q                   ;%����ڵ�Ϊ����
    u(k)=u1;
    if k<40,y(k+1)=0.8*sin(y(k))+1.2*u(k);
else  y(k+1)=sin(0.4*y(k))+1.2*u(k);
end
 %---����lw
  e(k)=r(k)-y(k);
  E(k)=e(k)^2/2;
lw=lw+a2*e(k)*q';
 lww(k)=lw(1,1);
%---����iw 
   h=sign((q-q00)./(x-x00));
   dw(1,:)=a1*e(k)*q(1)*h(1)*ry';
   dw(2,:)=a1*e(k)*q(2)*h(2)*ry';
   dw(3,:)=a1*e(k)*q(3)*h(3)*ry';
 iw=iw+dw;
 iww(k)=iw(1,1);
q00=q;
x00=x;
end

figure(1);
subplot(221),plot(y,'r');hold on;plot(r,'b');
             ylabel('y  r','color','r');   
             title('����ϵͳ����r�����y');
subplot(223),plot(u(1:79),'b');
             ylabel('������u','color','r');xlabel('k');                         
subplot(222),plot(iww(1:79),'r');hold on;plot(lww(1:79),'b');
             ylabel('iw(1,1)  lw(1,1)','color','r');xlabel('k');
             title('����Ȩֵ��������');
subplot(224),plot(E(1:79));
             ylabel('Ŀ�꺯��E','color','r');xlabel('k');
