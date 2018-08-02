dt=0.02;% 控制时间间隔
RunT=6;% 运行时间
RunNum=length(0:dt:RunT);% 运行次数

%% 生成样本

r=-4:1:4;
Y=-5:0.5:5;
dY=-5:1:5;

rbfTy=3;

Count=1;
Num=length(r)*length(Y)*length(dY)*Count

X=zeros(5,Num);% [dy y | e de  y+1]
Yt=zeros(1,Num);

n=1;

olde=0;
e=0;
disp('样本生成');
model.ddy=0;
model.dy=0;
model.y=0;
for i=1:length(r)
    for j=1:length(Y)
        for k=1:length(dY)
            model.dy=dY(k);
            model.y=Y(j);
            X(1:2,n)=[model.dy;model.y];
            model=demoModel(model,r(i),dt);
            
            Yt=model.y*1.2;
            e=Yt-model.y;
            de=(e-olde)/dt;
            
            X(3:5,n)=[e;de;model.y];
            Yt(1,n)=r(i);
            n=n+1;
        end
    end
end

disp('训练');
% 训练

%{
DimX=3;
DimY=1;
NumHid=9;
Iteration=100;
rbf= createRBFNet( DimX,NumHid,DimY);

[id ,C]=kmeans(X.',rbf.numHid);
rbf.C=C';
disp('Init OK');

E=[];
figure(1);
for i=1:Iteration
    [rbf,g]=rbfTrain(rbf,X,Yt);
    if norm(g)<0.01
        break;
    end
    e=rbfBatErrorFun(rbf,X,Yt)
    
end
%}
net=newrb(X,Yt,0,1,900,100);

% 测试
rbfY=zeros(RunNum,1);
U=zeros(RunNum,1);
model.ddy=0;
model.dy=0;
model.y=0;
Eold=0;


for t=1:RunNum*3
    e=rbfTy-model.y;
    de=(e-Eold)/dt;
    Eold=e;
     u=sim(net,[model.dy;model.y;e;de;rbfTy]); % 0;0;;
%    u=yRBFnet(rbf,[model.dy;model.y;rbfTy]);
    U(t)=u;
    model=demoModel(model,u,dt);
    rbfY(t)=model.y;
end
%% 绘图
figure(2);
plot([0; rbfY]);hold on;
plot(U);hold on;
