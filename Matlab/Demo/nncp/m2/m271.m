%m271.m      CMAC逼近非线性函数：d=sin(2*pi*u/360)^2  
clear all;
close all;

%---参数设置
a=1.8                 ;%学习步长
q=190                 ;%量化级
N=5;
c=5                   ;%泛化常数
L=20                  ;%样本长度
min=0;                ;% 输入范围                                 ; 
max=190;
w=zeros(N,1);
w1=w;
dw=w;
ww=zeros(L,1);

%---输入、输出样本集                     
u=0:10:190;
d=sin(2*pi*u/360).^2 ;
 
%---CMAC训练，逼近非线性函数
for p=1:L
s(p)=round((u(p)-min)*q/(max-min));%输入u被量化编码
sum=0;
for i=1:c
   ad(i)=mod(s(p)+i,N)+1          ;%求杂散地址
   sum=sum+w(ad(i))               ;%求权系值和
end
y(p)=sum                          ;%CMAC输出
e(p)=d(p)-y(p);
E(p)=e(p)^2/2                     ;%目标函数
dw=a*e(p)/c                       ;%权值增量
for i=1:c
   ad(i)=mod(s(p)+i,N)+1;
   w(ad(i))=w1(ad(i))+dw          ;%调整权系值
end
w1=w;
ww(p)=w(1);
end

figure;
subplot(221),plot(u,'b*');ylabel('输入u');
subplot(223),plot(d,'b*');hold on;plot(y,'rO');
             ylabel('函数d   CMAC输出y');xlabel('L=20  ');
subplot(222),plot(E,'b*');ylabel('目标函数E');
subplot(224),plot(ww,'mo'),ylabel('一个权值w(1)');xlabel('L=20 ');
w                       %观测L=20的权系值

