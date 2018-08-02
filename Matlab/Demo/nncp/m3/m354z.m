%m354z.m      仿真系统：y(k)=5*y(k-1)/(2.5+y(k-1)^2)+u(k-1)^3 
%             辨识器：CMAC+TDL
%             适用于在线辨识
clear all;
close all;

%---初始设置
a=1.8                        ;%训练步长
q=100                        ;%量化级
N=5;
c=5;                         
L=120;
min=-1.0                     ;% 输入范围                                 ; 
max=1.0;
u=zeros(L,1);
y=u;
yi=y;
w=zeros(N,1);
w1=w;
dw=w;
ww=zeros(L,1);

%----系统辨识
for k=2:L
u(k)=0.6*cos(2*pi*k/60)-0.4*cos(2*pi*k/40)  ;%系统输入
y(k)=u(k-1)^3+5*y(k-1)/(2.5+y(k-1)^2)       ;%系统输出
s(k)=round((u(k-1)-min)*q/(max-min))        ;%输入u被量化编码
sum=0;
for i=1:c
   ad(i)=mod(s(k)+i,N)+1                    ;%求杂散地址
   sum=sum+w(ad(i))                         ;%求权系值和
end
yi(k)=sum                                   ;%辨识器输出
e(k)=y(k)-yi(k);
E(k)=e(k)^2/2                               ;%目标函数
dw=a*e(k)/c                                 ;%权值增量
for i=1:c
   ad(i)=mod(s(k)+i,N)+1;
   w(ad(i))=w1(ad(i))+dw                   ;%调整权系值
end
w1=w;
ww(k)=w(1);
end

figure(1);  
k=1:L;
subplot(221),plot(k,u,'r');axis([0 120 -1 1]);ylabel('输入u(k)');
subplot(223),plot(k,y,'b',k,yi,'r');axis([ 0 120 0 2.5]);
               ylabel('系统、辨识器输出y(k)  yi(k)');xlabel(' k');               
subplot(222),plot(k,E(1:120));ylabel('目标函数E(k)');axis([0 120 0 0.05]);
subplot(224),plot(k,ww(1:120),'m');axis([0 120 0 0.5]);
              ylabel('权值调整过程w(1)');xlabel('k');
       
w                               %观测k=120的权系值
