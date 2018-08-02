%% Demo1 绘制B-Spline基函数
% 说明：准均匀基函数
%%
n=6;
k=4;
T=getT(n,k);
t=0:0.1:T(length(T));
b1=B(t,1,k,T);
b2=B(t,2,k,T);
b3=B(t,3,k,T);
b4=B(t,4,k,T);
b5=B(t,5,k,T);
b6=B(t,6,k,T);

plot(b1,'color','g');hold on;
plot(b2,'color','b');hold on;
plot(b3,'color','r');hold on;
plot(b4,'color','y');hold on;
plot(b5,'color','r');hold on;
plot(b6,'color','c');hold on;
axis([-1 length(b1) -1.5 1.5]);

