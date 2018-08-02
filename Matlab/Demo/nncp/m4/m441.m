%m441.m         ����У������:
%               ������� y(k)=0.8sin[y(k-1)]+1.2u(k-1) ,    k<200                                                                      
%                        y(k)=0.8sin[y(k-1)]+y(k-1)/7+1.2u(k-1),  k>=200                                       
clear all;
close all;

net=newff([-1 1],[10,1],{'tansig','purelin'}); %����BPNNģ��N1,10,1

%---��ʼ����
iw=(rand(10,1)-0.2)/10;
net.iw{1,1}=iw;
lw=net.lw{2,1};
i=100;
r1=ones(1,i);r2=-ones(1,2*i);r3=ones(1,i);
r=[r1 r2 r3];                               ;%�����ϵͳ����
v=zeros(1,4*i);v(50)=0.3                    ;%���Ŷ�
 y=zeros(1,4*i);u=y;ng=y;
 e=y;e1=y;
 E=e;
 llw=zeros(4*i,1);llww=zeros(4*i,1);
 lww=zeros(10,10);
a=0.04                                      ;%ѵ������

%---�����ʶ������������ϵͳ�����
 for k=2:4*i   
ya=y(k-1)                                   ;%��ʶ������
x=(net.iw{1,1}+net.b{1})*ya                 ;%��ʶ������״̬ 
o=tansig(x)                                 ;%��ʶ��������� 
ng=(net.lw{2,1}+net.b{2})*o ;
yi(k)=ng+1.2*u(k-1)                         ;%��ʶ�����
u(k-1)=(r(k)-ng)/1.2;                       ;%��������� 
if (k<200 ),     
     y(k)=0.8*sin(y(k-1))+1.2*u(k-1)+v(k)   ;%����ϵͳ���
else y(k)=0.8*sin(y(k-1))+y(k-1)/7+1.2*u(k-1)+v(k);
   end 
       e1(k)=y(k)-yi(k);
       e(k)=r(k)-y(k);
       E(k)=e(k)^2/2                        ;%Ŀ�꺯��
       
%---��ʶ��ѵ��
lw=net.lw{2,1}+a*e1(k)*o';
b2=net.b{2}+a*e1(k);
net.lw{2,1}=lw;
net.b{2}=b2;
for i=1:10
lww(i,i)=lw(1,i);
end
iw=net.iw{1,1}+a*e1(k)*lww*dtansig(x,o)*ya;
b1=net.b{1}+a*e1(k)*lww*dtansig(x,o);
net.iw{1,1}=iw;
net.b{1}=b1;
llw(k)=lw(1,1);
llww(k)=lw(1,2);
end

figure;
subplot(221),plot(y,'r');hold on;plot(r,'b');hold on;plot(v,'k');
                         ylabel('y    r    v');
                         title('����ϵͳ����r�����y���Ŷ�v');
subplot(223),plot(u,'b');ylabel('������u');xlabel('k');       
subplot(222),plot(E,'r');ylabel('Ŀ�꺯��E');
subplot(224),plot(llw,'r');hold on;plot(llww,'b');ylabel('����Ȩֵ�������� ');xlabel('k'); 