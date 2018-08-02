%m561b.m       一阶线性离散系统辨识（用GA） 
%             仿真系统：y(k)=-0.2y(k-1)+0.50u(k-1)              
%             二进编码
%             适应度函数=1/总目标函数
%             观测搜索过程            

clear all;
close all;

%---参数设置
N=20                ;%种群的个体数   
T=40                ;%迭代终了代数    
d=10                ;%变量二进位串长度
pc=0.6              ;%交叉概率
pm=0.01             ;%变异概率
max=1               ;%变量范围
min=-1;
y=zeros(100,1);
e=zeros(100,1);
S=round(rand(N,3*d));%随机生成二进位串（长度L=2*d）
u=rand(100,1)-0.5     ;%系统随机输入

%---用ga进行系统辨识
  for t=1:T   
   for n=1:N
m=S(n,:);
p1=0;q1=0;
%---解码（由二进到十进）
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
figure(1)                ;%画每一代p、q候补解、解集合
 plot(pp,qq,'g+',-0.2,0.5,'ro');xlabel('p');
                ylabel('q');axis([-1 1 -1 1]),pause
 
 %---求每一代中，第n对p、q参数辨识的目标函数、总目标函数   
  for n=1:N 
     y1=0;
     u1=0;
     J=0; 
    for k=1:100
      ym(k)=pp(n)*y1+qq(n)*u1  ;%辨识器输出
      y(k)=-0.2*y1+0.5*u1      ;%仿真系统输出
      e(k)=y(k)-ym(k);     
      E(k)=e(k)^2/2            ;%求目标函数
      J=J+E(k)                 ;%求总目标函数
      JJ(n)=J;
     y1=y(k);
     u1=u(k);
    end 
 
 figure(2)  ;%画u(k)输入下仿真系统输出y(k)，每一代，第n对p、q参数的辨识输出ym(k)、
 %           每一代，第n对p、q参数的辨识输出ym(k)、辨识误差e(k)
 subplot(311),plot(y,'b');ylabel('y(k)');
 subplot(312),plot(ym,'r');ylabel('ym(k)');
 subplot(313),plot(e,'g');xlabel('k');ylabel('e(k)'),pause
    t         %观测每一代，第n对p、q辨识参数
    n
   p=pp(n)
   q=qq(n),pause
  end

%---求每代最优的p、q辨识参数
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
 
J=1/Bestfi    %观测终了代数的总目标函数、辨识参数p、q
a11=p
a22=q

figure(3)   ;%画每代总目标函数最小值Jmin、平均值Jmean                   
t=1:T;               
subplot(211),plot(1./bfi,'r');xlabel('t');ylabel('Jmin');
subplot(212),plot(1./fmean,'b');xlabel('t');ylabel('Jmean');

