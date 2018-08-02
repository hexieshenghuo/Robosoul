%m552b.m     min f(x,y)=100(x^2-y)^2+(1-x)^2,  -2.048<=x,y<=2.048
%           二进编码
%           适应度函数=1/目标函数
%           观测寻优过程
clear all;
close all;

%---参数设置
N=40                ;%种群的个体数   
T=100               ;%迭代终了代数    
d=10                ;%变量x、y二进位串长度
pc=0.6              ;%交叉概率
pm=0.1              ;%变异概率
umax=2.048          ;%变量范围
umin=-2.048;

S=round(rand(N,2*d));%随机生成二进位串（长度L=2*d）

%---求函数极小值ga算法
for t=1:T
for n=1:N
m=S(n,:);
x1=0;y1=0;

%---解码（由二进到十进）
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
F(n)=100*(x^2-y)^2+(1-x)^2    ;%求目标函数
end

figure(1)                     ;%画每代候补解、解集合
plot(xx,yy,'b*',1,1,'rO');xlabel('x');
              ylabel('y');axis([-2.1 2.1 -2.1 2.1]),pause

%---求每代最优解
fi=1./F                      ;%适应度函数=1/目标函数                         
[Oderfi,Indexfi]=sort(fi)    ;%适应度函数由小到大排序 
Bestfi=Oderfi(N);           
BestS=S(Indexfi(N),:);     
bfi(t)=Bestfi;

%---选择（轮盘赌法）
   fi_sum=sum(fi);
   fmean(t)=sum(fi)/N;
   fi_Size=(Oderfi/fi_sum)*N;
   fi_S=floor(fi_Size);         
   k=1;
   for i=1:N
      for j=1:fi_S(i)        %选择与复制 
       TempS(k,:)=S(Indexfi(i),:);  
         k=k+1;             
      end
   end
   
%---一点交叉
n1=ceil(20*rand);
for i=1:2:(N-1)
    temp=rand;
    if pc>temp                  %交叉条件
    for j=n1:20
        TempS(i,j)=S(i+1,j);
        TempS(i+1,j)=S(i,j);
    end
    end
end
TempS(N,:)=BestS;
S=TempS;
   
%---变异     
   for i=1:1:N
      for j=1:2*d
         temp=rand;
         if pm>temp                %变异条件
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
 
fmin=1/Bestfi                %观测终了代数的极小值（解）
BestS
x
y
figure(2)                   ;%画终了代数的极小点（解）      
t=1:T;
plot(x,y,'b*',1,1,'rO');xlabel('x');ylabel('y');
                        axis([-2.1 2.1 -2.1 2.1]),pause
figure(3)                   ;%画每代适应度最小值fmin、平均值
subplot(221),plot(t,1./bfi,'r');xlabel('t');
                                ylabel('每代适应度最小值fmin');
subplot(222),plot(x,y,'b*',1,1,'rO');
             xlabel('x');ylabel('y');axis([-2.1 2.1 -2.1 2.1]);
             title('第100（终了）代的解')