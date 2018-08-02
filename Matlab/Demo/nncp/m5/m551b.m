%m551b.m    max z=f(x,y)=100(x^2-y)^2+(1-x)^2 ,-2.048<=x,y<=2.048 
%           ʵ������
%           �۲���������
clear all;
close all;

%---��������
N=40                   ;%������
T=200                  ;%���˵Ĵ���
d=2                    ;%����ʵ������
pc=0.6                 ;%�������
%pm=0.008              ;%������ʳ�ֵ
pm=0.10-[1:N]*(0.01)/N ;%�仯�ı������
max=2.048              ;%�����ķ�Χ
min=-2.048;      
X(:,1)=min+(max-min)*rand(N,1);%���������ʼ��Ⱥ
X(:,2)=min+(max-min)*rand(N,1);

%---��������ֵga�㷨
for t=1:T
%---��Ŀ�꺯��
 for n=1:N
   xn=X(n,:);
   x=xn(1);
   y=xn(2);
   xx(n)=x;
   yy(n)=y;
   F(n)=100*(x^2-y)^2+(1-x)^2;
 end
 
 figure(1)         ;%���򲹽⡢�⼯�Ϸֲ�
   plot(xx,yy,'g*',-2.048,-2.048,'ro',2.048,-2.048,'ro');
                ylabel('y');xlabel('x');
                axis([-2.1 2.1 -2.1 2.1]),pause
 fi=F;
   [Oderfi,Indexfi]=sort(fi);    
   fmax=Oderfi(N);          
   Smax=X(Indexfi(N),:); 
  
   fb(t)=fmax            ;%ÿ������Ӧ�����ֵ 
  %t                      %�۲����
  % fmax                  %�۲�ÿ������Ӧ�����ֵ
  % Smax                  %�۲�ÿ������������
   
%---ѡ�����̶ķ���
    fsum=sum(fi);
    fmean(t)=fsum/N          ;%ÿ������Ӧ��ƽ��ֵ
    fis=(Oderfi/fsum)*N;
    fs=floor(fis);                    
    r=N-sum(fs);  
    Rest=fis-fs;
   [RestValue,Index]=sort(Rest); 
   for i=N:-1:N-r+1
      fs(Index(i))=fs(Index(i))+1;    
   end

   k=1;
   for i=N:-1:1       
      for j=1:fs(i)  
       TempX(k,:)=X(Indexfi(i),:);      
         k=k+1;                           
      end
   end

 %---һ�㽻��
    for i=1:2:(N-1)
          temp=rand;
      if pc>temp                      %��������
          alfa=rand;
          TempX(i,:)=alfa*X(i+1,:)+(1-alfa)*X(i,:);  
          TempX(i+1,:)=alfa*X(i,:)+(1-alfa)*X(i+1,:);
      end
    end
    TempX(N,:)=Smax;
    X=TempX;
    
%---����
Pm_rand=rand(N,d);
Mean=([max max]+[min min])/2; 
Dif=[max max]-[min min];
   for i=1:N
      for j=1:d
         if pm(i)>Pm_rand(i,j)        %��������
            TempX(i,j)=Mean(j)+Dif(j)*(rand-0.5);
         end
      end
   end

   TempX(N,:)=Smax;      
   X=TempX;
end

fmax          %�۲����˴��Ľ�
Smax

figure(2)    ;%�����˴��Ľ�
t=1:T;
plot(Smax(1),Smax(2),'g*',-2.048,-2.048,'rO',2.048,-2.048,'rO');
                xlabel('x');ylabel('y');axis([-2.1 2.1 -2.1 2.1]);
figure(3)    ;%��ÿ����Ӧ�����ֵ��ƽ��ֵ 
plot(t,fb,'r',t,fmean,'b');xlabel('t');ylabel('fmax     fmean');


