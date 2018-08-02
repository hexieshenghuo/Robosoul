%% 模型
A=[-0.8 -0.22;1 0];
B=[0.5;1];
C=[1 0.5];
X=[0;0];

% 迭代学习参数
Yd=1; 
T=50;  %控制次数
K=50;%迭代次数
Kp=0.5;
Ki=0.01;
Kd=0;

% 计算u0(t);
u=zeros(1,T);
e=zeros(1,T);

ShowY=zeros(K,T);
SumE=0;

for k=1:K
    X=[0;0];
    SumE=0;
    for t=1:T
        %计算当前输出
        SumE=SumE+e(t);
        de=e(t)-e(max(t-1,1));
        u(t)=u(t)+Kp*e(t)+Ki*SumE+Kd*de;
        X=A*X+B*u(t);
        Yt=C*X;
        e(t)=Yd-Yt;
        
        ShowY(k,t)=Yt;
    end
    disp(k);
end
n=1:T;
ShowY=[zeros(K,1) ShowY];
subplot(2,1,1);
plot(ShowY,'DisplayName','ShowY');
axis([1 T 0 1.8]);

optY=ShowY(end,:);
subplot(2,1,2);
plot(optY);
axis([1 T 0 1.8]);