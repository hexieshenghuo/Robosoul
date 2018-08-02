%m561b.m       һ��������ɢϵͳ��ʶ����GA�� 
%             ����ϵͳ��y(k)=-0.2y(k-1)+0.50u(k-1)              
%             ��������
%             ��Ӧ�Ⱥ���=1/��Ŀ�꺯��
%             �۲���������            

clear all;
close all;

%---��������
N=20                ;%��Ⱥ�ĸ�����   
T=40                ;%�������˴���    
d=10                ;%��������λ������
pc=0.6              ;%�������
pm=0.01             ;%�������
max=1               ;%������Χ
min=-1;
y=zeros(100,1);
e=zeros(100,1);
S=round(rand(N,3*d));%������ɶ���λ��������L=2*d��
u=rand(100,1)-0.5     ;%ϵͳ�������

%---��ga����ϵͳ��ʶ
  for t=1:T   
   for n=1:N
m=S(n,:);
p1=0;q1=0;
%---���루�ɶ�����ʮ����
m1=m(1:d);
  for i=1:d
    p1=p1+m1(i)*2^(i-1);
  end
p=(max-min)*p1/1023+min;
m2=m(d+1:2*d);
  for i=1:d
   q1=q1+m2(i)*2^(i-1);
  end
q=(max-min)*q1/1023+min; 
 pp(n)=p;
 qq(n)=q;
   end
figure(1)                ;%��ÿһ��p��q�򲹽⡢�⼯��
 plot(pp,qq,'g+',-0.2,0.5,'ro');xlabel('p');
                ylabel('q');axis([-1 1 -1 1]),pause
 
 %---��ÿһ���У���n��p��q������ʶ��Ŀ�꺯������Ŀ�꺯��   
  for n=1:N 
     y1=0;
     u1=0;
     J=0; 
    for k=1:100
      ym(k)=pp(n)*y1+qq(n)*u1  ;%��ʶ�����
      y(k)=-0.2*y1+0.5*u1      ;%����ϵͳ���
      e(k)=y(k)-ym(k);     
      E(k)=e(k)^2/2            ;%��Ŀ�꺯��
      J=J+E(k)                 ;%����Ŀ�꺯��
      JJ(n)=J;
     y1=y(k);
     u1=u(k);
    end 
 
 figure(2)  ;%��u(k)�����·���ϵͳ���y(k)��ÿһ������n��p��q�����ı�ʶ���ym(k)��
 %           ÿһ������n��p��q�����ı�ʶ���ym(k)����ʶ���e(k)
 subplot(311),plot(y,'b');ylabel('y(k)');
 subplot(312),plot(ym,'r');ylabel('ym(k)');
 subplot(313),plot(e,'g');xlabel('k');ylabel('e(k)'),pause
    t         %�۲�ÿһ������n��p��q��ʶ����
    n
   p=pp(n)
   q=qq(n),pause
  end

%---��ÿ�����ŵ�p��q��ʶ����
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
 
J=1/Bestfi    %�۲����˴�������Ŀ�꺯������ʶ����p��q
a11=p
a22=q

figure(3)   ;%��ÿ����Ŀ�꺯����СֵJmin��ƽ��ֵJmean                   
t=1:T;               
subplot(211),plot(1./bfi,'r');xlabel('t');ylabel('Jmin');
subplot(212),plot(1./fmean,'b');xlabel('t');ylabel('Jmean');

