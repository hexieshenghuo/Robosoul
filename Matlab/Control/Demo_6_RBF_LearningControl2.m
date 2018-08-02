%% RBF 学习控制 算法试验2
yt=1;
rbfyT=1;
y0=0;
rl=0.9;
RunTime=3;

DimX=3;  % [ e Se; de]
DimY=1;
NumHid=36;

dt=0.02;
RunNum=RunTime/dt;
yT=ones(RunNum,1)*yt;

SingleTrainTime=1000;

kp=6;
ki=0.016;
kd=0.018;

rbf=[];
ModelFileName='rbfTrained.mat';
if ( exist(ModelFileName,'file')==2 )% 判断文件知否存在
    load 'rbfTrained.mat'
else
    disp('No Model File...');
    rbf=createRBFNet(DimX,NumHid,DimY,1,1);    
end
plotU=zeros(RunNum,1);
plotR=zeros(RunNum,1);
plotY=zeros(RunNum,1);

model.ddy=0;
model.dy=0;
model.y=0;
figure(1);
olde=0;
Se=0;

X=zeros(3,RunNum);
Yt=zeros(1,RunNum);

for i=1:RunNum
    
    e=yT(i)-model.y;
    de=(e-olde)/dt;
    Se=Se+e*dt;
    
    olde=e;
    X(:,i)=[ e;Se;de];

    r=pidController(kp,ki,kd,e,Se,de);
    Yt(i)=r;

    model=demoModel(model,r,dt);
    
    plotY(i,:)=model.y;
    plotR(i,:)=r;
%     plotU(i,:)=u;
    clf;
    
%    plot(plotU);hold on;
   plot([0;plotY]);hold on;
%     plot(yT);hold on;;
    plot(plotR);hold on;
    
    drawnow;
end

Error=zeros(SingleTrainTime,1);

figure(3);

[id ,C]=kmeans(X.',rbf.numHid);
rbf.C=C;

for j=1:SingleTrainTime
        [rbf,f]=rbfTrain(rbf,X,Yt);
        Error(j)=f;
        clf;
         plot(Error);hold on;
    
    drawnow;
end

save rbfTrained.mat rbf;

%{ 
%}

%% 测试


model.ddy=0;
model.dy=0;
model.y=0;

olde=0;
Se=0;


testNum=3;
testNum=testNum/dt;
plotr=zeros(testNum,1);
rbfY=zeros(testNum,1);
U=zeros(testNum,1);
for t=1:testNum

    e=yT(i)-model.y;
    de=(e-olde)/dt;
    Se=Se+e*dt;
    
    olde=e;
    X=[ e;Se;de];
    r=pidController(kp,ki,kd,e,Se,de);
    u=yRBFnet(rbf,X);
    
    U(t)=u;
    plotr(t)=r;
    model=demoModel(model,r,dt);
    rbfY(t)=model.y;
end
figure(2);
plot([y0; rbfY]);hold on;
% plot(ones(length(rbfY),1)*rbfyT);hold on;
plot(U,'marker','o','markersize',1);hold on;
plot(plotr,'marker','.','markersize',1);hold on;
% plot(plotr-U,'marker','.','markersize',1);hold on;


