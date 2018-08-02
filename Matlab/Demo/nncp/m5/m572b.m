%m572b.m      ��������ϵͳ������PID���ƣ���GA����PID������ 
%            ����ϵͳ���ݺ�����P(s)=1/(s(s+1))              
%            ��������
%            ��Ӧ�Ⱥ���=1/��Ŀ�꺯��

%%%%%%%%     ��ÿһ����ÿ��Kp��Ki��Kd������PID����ϵͳ�����
clear all;
close all;

%---��������
N=20                ;%��Ⱥ�ĸ�����   
T=40                ;%�������˴���    
d=10                ;%��������λ������
pc=0.6              ;%�������
pm=0.01             ;%�������
max=10              ;%������Χ
min=0;

y=zeros(1000,1);
e=zeros(1000,1);
S=round(rand(N,3*d));%������ɶ���λ��������L=2*d��
r=ones(1000,1);      ;%����ϵͳ��λ��Ծ��������

%��ga��������PID����������
  for t=1:T   
   for n=1:N
m=S(n,:);
Kp1=0;Ki1=0;Kd1=0;

%---���루�ɶ�����ʮ����
m1=m(1:d);
  for i=1:d
    Kp1=Kp1+m1(i)*2^(i-1);
  end
Kp=(max-min)*Kp1/1023+min;
m2=m(d+1:2*d);
  for i=1:d
   Ki1=Ki1+m2(i)*2^(i-1);
  end
Ki=(max-min)*Ki1/1023+min; 
m3=m(2*d+1:3*d);
  for i=1:d
   Kd1=Kd1+m3(i)*2^(i-1);
  end
Kd=(max-min)*Kd1/1023+min; 
 Kpp(n)=Kp;
 Kii(n)=Ki;
 Kdd(n)=Kd;
   end
% figure(1)        ;%��Kp��Ki��Kd�Ż�����
 %plot3(Kpp,Kii,Kdd,'b*');xlabel('Kp');ylabel('Ki');
 %         zlabel('Kd');axis([0 1 0 1 0 1]),pause
  
 %---�����ױ�������P(s)��z���ݺ���Pd(z)
 a=1;
 Ts=0.1                     ;%��������
 sys=tf(a,[1,a,0])          ;%P(s) 
 dsys=c2d(sys,Ts,'zoh')     ;%��P(s)��Pd(z)
 [num,den]=tfdata(dsys,'v') ;%Pd(z)���ӷ�ĸ�Ķ���ʽ
 %---��ÿһ���У�n��Kp��Ki��Kd������PID����ϵͳ����Ŀ�꺯��J 
  for n=1:N
     y1=0;y2=0;
     u1=0;u2=0;
     J=0;
     ee=[0;0;0]; 
    for k=2:1000
      u(k)=Kpp(n)*ee(1)+Kii(n)*ee(2)+Kdd(n)*ee(3)     ;%PID���������
      y(k)=-den(2)*y1-den(3)*y2+num(2)*u1+num(3)*u2   ;%����ϵͳ���
      e(k)=r(k)-y(k);     
      E(k)=e(k)^2/2                                   ;%��Ŀ�꺯��
      J=J+E(k)                                       ;%����Ŀ�꺯��
      JJ(n)=J;
     y1=y(k);y2=y1;
     u1=u(k);u2=u1;
     ee(1)=e(k);ee(2)=ee(2)+e(k);ee(3)=e(k)-e(k-1);
    end
    
 clc;clf;
 figure(2)  ;%��ÿһ������n��Kp��Ki��Kd������PID����ϵͳ�����
 tt=1/10:0.1:1000/10;
 plot(tt,y,'r');hold on;plot(tt,r,'b'); xlabel('t(s)');ylabel('y'),pause
 %   t         %�۲⶯̬��Ӧ�õ�J��Kp��Ki����
 %   n
 %  Kp=Kpp(n)
 %  Ki=Kii(n)
 %  Kd=Kdd(n),pause
  end

%---��ÿ�����ŵ�PID����
fi=1./JJ                      ;%��Ӧ�Ⱥ���=1/��Ŀ�꺯��                         
[Oderfi,Indexfi]=sort(fi)     ;%��Ӧ�Ⱥ�����С�������� 
Bestfi=Oderfi(N);           
BestS=S(Indexfi(N),:);     
bfi(t)=Bestfi;

%---ѡ�����̶ķ���
   fi_sum=sum(fi);
   fmean(t)=sum(fi)/N;
   fi_Size=(Oderfi/fi_sum)*N;
   fi_S=floor(fi_Size);         
   k=1;
   for i=1:N
      for j=1:fi_S(i)        %ѡ���븴�� 
       TempS(k,:)=S(Indexfi(i),:);  
         k=k+1;             
      end
   end
   
%---һ�㽻��
n1=ceil(20*rand);
for i=1:2:(N-1)
    temp=rand;
    if pc>temp                  %��������
    for j=n1:20
        TempS(i,j)=S(i+1,j);
        TempS(i+1,j)=S(i,j);
    end
    end
end
TempS(N,:)=BestS;
S=TempS;
   
%---����     
   for i=1:N
      for j=1:2*d
         temp=rand;
         if pm>temp                %��������
            if TempS(i,j)==0
               TempS(i,j)=1;
            else
               TempS(i,j)=0;
            end
        end
      end
   end
TempS(N,:)=BestS;
S=TempS;
  end
 
J=1/Bestfi    %�۲����˴�������Ŀ�꺯����Kp��Ki��Kd
Kp
Ki
Kd
figure(3)   ;%��ÿ����Ŀ�꺯����СֵJmin��ƽ��ֵJmean                   
t=1:T;               
subplot(211),plot(1./bfi,'r');xlabel('t');ylabel('Jmin');
subplot(212),plot(1./fmean,'b');xlabel('t');ylabel('Jmean');

