%m552b.m     min f(x,y)=100(x^2-y)^2+(1-x)^2,  -2.048<=x,y<=2.048
%           ��������
%           ��Ӧ�Ⱥ���=1/Ŀ�꺯��
%           �۲�Ѱ�Ź���
clear all;
close all;

%---��������
N=40                ;%��Ⱥ�ĸ�����   
T=100               ;%�������˴���    
d=10                ;%����x��y����λ������
pc=0.6              ;%�������
pm=0.1              ;%�������
umax=2.048          ;%������Χ
umin=-2.048;

S=round(rand(N,2*d));%������ɶ���λ��������L=2*d��

%---������Сֵga�㷨
for t=1:T
for n=1:N
m=S(n,:);
x1=0;y1=0;

%---���루�ɶ�����ʮ����
m1=m(1:d);
for i=1:d
   x1=x1+m1(i)*2^(i-1);
end
x=(umax-umin)*x1/1023+umin;
m2=m(d+1:1:2*d);
for i=1:d
   y1=y1+m2(i)*2^(i-1);
end
y=(umax-umin)*y1/1023+umin;
xx(n)=x;
yy(n)=y;
F(n)=100*(x^2-y)^2+(1-x)^2    ;%��Ŀ�꺯��
end

figure(1)                     ;%��ÿ���򲹽⡢�⼯��
plot(xx,yy,'b*',1,1,'rO');xlabel('x');
              ylabel('y');axis([-2.1 2.1 -2.1 2.1]),pause

%---��ÿ�����Ž�
fi=1./F                      ;%��Ӧ�Ⱥ���=1/Ŀ�꺯��                         
[Oderfi,Indexfi]=sort(fi)    ;%��Ӧ�Ⱥ�����С�������� 
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
   for i=1:1:N
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
 
fmin=1/Bestfi                %�۲����˴����ļ�Сֵ���⣩
BestS
x
y
figure(2)                   ;%�����˴����ļ�С�㣨�⣩      
t=1:T;
plot(x,y,'b*',1,1,'rO');xlabel('x');ylabel('y');
                        axis([-2.1 2.1 -2.1 2.1]),pause
figure(3)                   ;%��ÿ����Ӧ����Сֵfmin��ƽ��ֵ
subplot(221),plot(t,1./bfi,'r');xlabel('t');
                                ylabel('ÿ����Ӧ����Сֵfmin');
subplot(222),plot(x,y,'b*',1,1,'rO');
             xlabel('x');ylabel('y');axis([-2.1 2.1 -2.1 2.1]);
             title('��100�����ˣ����Ľ�')