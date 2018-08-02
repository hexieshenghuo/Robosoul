%m354z.m      ����ϵͳ��y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3 
%             ��ʶ����CMAC+TDL
%             ���������߱�ʶ
clear all;
close all;

%---��ʼ����
a=1.8                        ;%ѵ������
q=100                        ;%������
N=5;
c=5;                         
L=120;
min=-1.0                     ;% ���뷶Χ                                 ; 
max=1.0;
u=zeros(L,1);
y=u;
yi=y;
w=zeros(N,1);
w1=w;
dw=w;
ww=zeros(L,1);

%----ϵͳ��ʶ
for k=2:L
u(k)=0.6*cos(2*pi*k/60)-0.4*cos(2*pi*k/40)  ;%ϵͳ����
y(k)=u(k-1)^3+5*y(k-1)/(2.5+y(k-1)^2)       ;%ϵͳ���
s(k)=round((u(k-1)-min)*q/(max-min))        ;%����u����������
sum=0;
for i=1:c
   ad(i)=mod(s(k)+i,N)+1                    ;%����ɢ��ַ
   sum=sum+w(ad(i))                         ;%��Ȩϵֵ��
end
yi(k)=sum                                   ;%��ʶ�����
e(k)=y(k)-yi(k);
E(k)=e(k)^2/2                               ;%Ŀ�꺯��
dw=a*e(k)/c                                 ;%Ȩֵ����
for i=1:c
   ad(i)=mod(s(k)+i,N)+1;
   w(ad(i))=w1(ad(i))+dw                   ;%����Ȩϵֵ
end
w1=w;
ww(k)=w(1);
end

figure(1);  
k=1:L;
subplot(221),plot(k,u,'r');axis([0 120 -1 1]);ylabel('����u(k)');
subplot(223),plot(k,y,'b',k,yi,'r');axis([ 0 120 0 2.5]);
               ylabel('ϵͳ����ʶ�����y(k)  yi(k)');xlabel(' k');               
subplot(222),plot(k,E(1:120));ylabel('Ŀ�꺯��E(k)');axis([0 120 0 0.05]);
subplot(224),plot(k,ww(1:120),'m');axis([0 120 0 0.5]);
              ylabel('Ȩֵ��������w(1)');xlabel('k');
       
w                               %�۲�k=120��Ȩϵֵ
