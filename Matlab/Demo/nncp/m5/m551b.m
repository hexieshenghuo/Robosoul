%m551b.m    max z=f(x,y)=100(x^2-y)^2+(1-x)^2 ,-2.048<=x,y<=2.048 
%           实数编码
%           观测搜索过程
clear all;
close all;

%---参数设置
N=40                   ;%个体数
T=200                  ;%终了的代数
d=2                    ;%两个实数变量
pc=0.6                 ;%交叉概率
%pm=0.008              ;%变异概率常值
pm=0.10-[1:N]*(0.01)/N ;%变化的变异概率
max=2.048              ;%变量的范围
min=-2.048;      
X(:,1)=min+(max-min)*rand(N,1);%随机产生初始种群
X(:,2)=min+(max-min)*rand(N,1);

%---求函数极大值ga算法
for t=1:T
%---求目标函数
 for n=1:N
   xn=X(n,:);
   x=xn(1);
   y=xn(2);
   xx(n)=x;
   yy(n)=y;
   F(n)=100*(x^2-y)^2+(1-x)^2;
 end
 
 figure(1)         ;%画候补解、解集合分布
   plot(xx,yy,'g*',-2.048,-2.048,'ro',2.048,-2.048,'ro');
                ylabel('y');xlabel('x');
                axis([-2.1 2.1 -2.1 2.1]),pause
 fi=F;
   [Oderfi,Indexfi]=sort(fi);    
   fmax=Oderfi(N);          
   Smax=X(Indexfi(N),:); 
  
   fb(t)=fmax            ;%每代的适应度最大值 
  %t                      %观测代数
  % fmax                  %观测每代的适应度最大值
  % Smax                  %观测每代的最优向量
   
%---选择（轮盘赌法）
    fsum=sum(fi);
    fmean(t)=fsum/N          ;%每代的适应度平均值
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

 %---一点交叉
    for i=1:2:(N-1)
          temp=rand;
      if pc>temp                      %交叉条件
          alfa=rand;
          TempX(i,:)=alfa*X(i+1,:)+(1-alfa)*X(i,:);  
          TempX(i+1,:)=alfa*X(i,:)+(1-alfa)*X(i+1,:);
      end
    end
    TempX(N,:)=Smax;
    X=TempX;
    
%---变异
Pm_rand=rand(N,d);
Mean=([max max]+[min min])/2; 
Dif=[max max]-[min min];
   for i=1:N
      for j=1:d
         if pm(i)>Pm_rand(i,j)        %变异条件
            TempX(i,j)=Mean(j)+Dif(j)*(rand-0.5);
         end
      end
   end

   TempX(N,:)=Smax;      
   X=TempX;
end

fmax          %观测终了代的解
Smax

figure(2)    ;%画终了代的解
t=1:T;
plot(Smax(1),Smax(2),'g*',-2.048,-2.048,'rO',2.048,-2.048,'rO');
                xlabel('x');ylabel('y');axis([-2.1 2.1 -2.1 2.1]);
figure(3)    ;%画每代适应度最大值、平均值 
plot(t,fb,'r',t,fmean,'b');xlabel('t');ylabel('fmax     fmean');


