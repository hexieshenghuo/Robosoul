%m571b.m    线性离散系统的PID控制（用GA整定PID参数） 
%          仿真系统：y(k)=1.368y(k-1)-0.368y(k-2)+0.368u(k-1)+0.264u(k-2)              
%          二进编码
%          适应度函数=1/总目标函数

%%%%%%%    画每一代，每对Kp、Ki、Kd参数的PID控制系统的输出   
clear all;
close all;

%---参数设置
N=20                ;%种群的个体数   
T=40                ;%迭代终了代数    
d=10                ;%变量二进位串长度
pc=0.6              ;%交叉概率
pm=0.01             ;%变异概率
max=1               ;%变量范围
min=0;
y=zeros(100,1);
e=zeros(100,1);
S=round(rand(N,3*d));%随机生成二进位串（长度L=2*d）
r=ones(100,1);      ;%控制系统单位阶跃输入序列

%---用ga整定PID控制器参数
  for t=1:T   
   for n=1:N
m=S(n,:);
Kp1=0;Ki1=0;Kd1=0;

%---解码（由二进到十进）
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
% figure(1)                         ;%画Kp、Ki、Kd优化过程
 %plot3(Kpp,Kii,Kdd,'b*');xlabel('Kp');
 %                       ylabel('Ki');zlabel('Kd');axis([0 1 0 1 0 1]),pause
 
 %---求每一代中，N=40对Kp、Ki、Kd参数的PID控制系统的总目标函数J 
  for n=1:N
     y1=0;y2=0;
     u1=0;u2=0;
     J=0;
     ee=[0;0;0];   
    for k=2:100
      u(k)=Kpp(n)*ee(1)+Kii(n)*ee(2)+Kdd(n)*ee(3);%PID控制器输出
      y(k)=1.368*y1-0.368*y2+0.368*u1+0.264*u2   ;%仿真系统输出
      e(k)=r(k)-y(k);     
      E(k)=e(k)^2/2                              ;%求目标函数
      J=J+E(k)                                   ;%求总目标函数
      JJ(n)=J;
     y1=y(k);y2=y1;
     u1=u(k);u2=u1;
     ee(1)=e(k);ee(2)=ee(2)+e(k);ee(3)=e(k)-e(k-1);
    end
    
 clc;clf;
 figure(2)  ;%画每一代，第n对Kp、Ki、Kd参数的PID控制系统的输出
 plot(y,'r');hold on;plot(r,'b'); xlabel('k');ylabel('y(k)'),pause
    t         %观测动态响应好的J、Kp、Ki参数
    n
   Kp=Kpp(n)
   Ki=Kii(n)
   Kd=Kdd(n),pause
  end

%---求每代最优的PID参数
fi=1./JJ                      ;%适应度函数=1/总目标函数                         
[Oderfi,Indexfi]=sort(fi)     ;%适应度函数由小到大排序 
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
   for i=1:N
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
 
J=1/Bestfi    %观测终了代数的总目标函数、Kp、Ki、Kd
Kp
Ki
Kd
figure(3)   ;%画每代总目标函数最小值Jmin、平均值Jmean                   
t=1:T;               
subplot(211),plot(1./bfi,'r');xlabel('t');ylabel('Jmin');
subplot(212),plot(1./fmean,'b');xlabel('t');ylabel('Jmean');

