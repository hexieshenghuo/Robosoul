%m271.m      CMAC�ƽ������Ժ�����d=sin(2*pi*u/360)^2  
clear all;
close all;

%---��������
a=1.8                 ;%ѧϰ����
q=190                 ;%������
N=5;
c=5                   ;%��������
L=20                  ;%��������
min=0;                ;% ���뷶Χ                                 ; 
max=190;
w=zeros(N,1);
w1=w;
dw=w;
ww=zeros(L,1);

%---���롢���������                     
u=0:10:190;
d=sin(2*pi*u/360).^2 ;
 
%---CMACѵ�����ƽ������Ժ���
for p=1:L
s(p)=round((u(p)-min)*q/(max-min));%����u����������
sum=0;
for i=1:c
   ad(i)=mod(s(p)+i,N)+1          ;%����ɢ��ַ
   sum=sum+w(ad(i))               ;%��Ȩϵֵ��
end
y(p)=sum                          ;%CMAC���
e(p)=d(p)-y(p);
E(p)=e(p)^2/2                     ;%Ŀ�꺯��
dw=a*e(p)/c                       ;%Ȩֵ����
for i=1:c
   ad(i)=mod(s(p)+i,N)+1;
   w(ad(i))=w1(ad(i))+dw          ;%����Ȩϵֵ
end
w1=w;
ww(p)=w(1);
end

figure;
subplot(221),plot(u,'b*');ylabel('����u');
subplot(223),plot(d,'b*');hold on;plot(y,'rO');
             ylabel('����d   CMAC���y');xlabel('L=20  ');
subplot(222),plot(E,'b*');ylabel('Ŀ�꺯��E');
subplot(224),plot(ww,'mo'),ylabel('һ��Ȩֵw(1)');xlabel('L=20 ');
w                       %�۲�L=20��Ȩϵֵ

