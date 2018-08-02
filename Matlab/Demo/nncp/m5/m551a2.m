%m551a2.m    max f(x,y)=100(x^2-y)^2+(1-x)^2,  -2.048<=x,y<=2.048
%           二进编码
%           适应度函数=目标函数
%%%%        观测寻优过程
clear all;
close all;

%---参数设置
N=40                ;%种群的个体数   
T=100               ;%迭代终了代数    
d=10                ;%变量x、y二进位串长度
pc=0.6              ;%交叉概率
pm=0.01              ;%变异概率
max=2.048          ;%变量范围
min=-2.048;

S=round(rand(N,2*d));%随机生成二进位串（个体数N=40，长度L=2*d）

%---求函数极大值的ga算法
  for t=1:T
%---求目标函数   
  for n=1:N
   m=S(n,:);
   x1=0;y1=0;

%---解码(二进制到十进制)
   m1=m(1:d);
    for i=1:d
      x1=x1+m1(i)*2^(i-1);
   end
x=(max-min)*x1/1023+min;
m2=m(d+1:1:2*d);
  for i=1:d
     y1=y1+m2(i)*2^(i-1);
  end
 y=(max-min)*y1/1023+min;
 xx(n)=x;
 yy(n)=y;
 F(n)=100*(x^2-y)^2+(1-x)^2  ;%求目标函数
end
figure(1)                   ;%画每代候补解、解集合
plot(xx,yy,'b*',-2.048,-2.048,'rO',2.048,-2.048,'rO');
                  xlabel('x');ylabel('y');
                  axis([-2.1 2.1 -2.1 2.1]),pause

 %---求每代最优解
 fi=F                       ;%适应度函数=目标函数                         
 [Oderfi,Indexfi]=sort(fi);     
 Bestfi=Oderfi(N);          
 BestS=S(Indexfi(N),:);      
 bfi(t)=Bestfi;

%---选择（轮盘赌法）
   fi_sum=sum(fi);
   fmean(t)=sum(fi)/N        ;%每代平均适应度值
   fi_Size=(Oderfi/fi_sum)*N;
   
   fi_S=floor(fi_Size);        
   k=1;
   for i=1:N
      for j=1:fi_S(i)        
       TempS(k,:)=S(Indexfi(i),:);  
         k=k+1;              
      end
   end
   
%---一点交叉(pc=0.6)
n1=ceil(20*rand);
for i=1:2:(N-1)
    temp=rand;
    if pc>temp                 
    for j=n1:20
        TempS(i,j)=S(i+1,j);
        TempS(i+1,j)=S(i,j);
    end
    end
end
TempS(N,:)=BestS;
S=TempS;
   
%---变异(pm=0.01)
   for i=1:1:N
      for j=1:2*d
         temp=rand;
         if pm>temp                
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
 
fmax=Bestfi               %观测终了代数的解
Smax=BestS
x
y
figure(2)               ;%画终了代数的极大点（解）
t=1:T;
plot(x,y,'b*',-2.048,-2.048,'rO',2.048,-2.048,'rO');
             xlabel('x');ylabel('y');axis([-2.1 2.1 -2.1 2.1]),pause
figure(3)                ;%画每代适应度最大值fmax、平均值fmean
plot(t,bfi,'r',t,fmean,'b');xlabel('t');ylabel('fmax   fmean');
                    