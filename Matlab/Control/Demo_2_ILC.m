%% 迭代学习演示列子

%% 模型
A=[-0.8 -0.22;1 0];
B=[0.5;1];
C=[1 0.5];
X=[0;0];

% 迭代学习参数

T=9000;  %控制次数
K=36;%迭代次数
Kp=0.00065;
Ki=0.0006;
Kd=0.0005;

inType=3;
if inType==1
    Yd=ones(1,T);
else
    Yd=1:T; 
    Yd=Yd*0.01;
    Yd=sin(Yd);
end


% 计算u0(t);
u=ones(1,T)*0;
e=Yd-zeros(1,T);

ShowY=zeros(K,T);
SumE=0;

for k=1:K
    X=[0;0];
    SumE=0;
    clf;
    for t=1:T
        %计算当前输出
        SumE=SumE+e(t);
        de=e(t)-e(max(t-1,1));
        u(t)=u(t)+Kp*e(t)+Ki*SumE+Kd*de;
        X=A*X+B*u(t);
        Yt=C*X;
        e(t)=Yd(t)-Yt;
        
        ShowY(k,t)=Yt;
    end
%     plot(ShowY(k,:));
%     axis([1 T 0 1.8]);
%     drawnow;
%     pause(0.6);
    disp(k);
end
n=1:T;
ShowY=[zeros(K,1) ShowY];
subplot(2,1,1);
plot(1:T+1,ShowY,'DisplayName','ShowY');
if inType==1
    axis([1 T 0 1.8]);    
else
    axis([1 T -1.8 1.8]);
end

optY=ShowY(end,:);
subplot(2,1,2);
plot(optY);
if inType==1
    axis([1 T 0 1.8]);    
else
    axis([1 T -1.8 1.8]);
end