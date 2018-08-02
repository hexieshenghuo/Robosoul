%% RBF 学习控制 算法试验 3

yt=0:0.02:1;
lyt=length(yt);
RunTime=2;
testNum=28;
BatTrainNum=70;
SingleTrainTime=8;
rbfyT=0.8;
y0=0;

dt=0.02;
RunNum=RunTime/dt;

DimX=3;  % [e Se de] 
DimY=1;
NumHid=96;

X=zeros(DimX,RunNum*lyt);
Yt=zeros(1,RunNum*lyt);

rbf=[];
ModelFileName='rbfTrained.mat';
if ( exist(ModelFileName,'file')==2 )% 判断文件知否存在
    load 'rbfTrained.mat'
else
    disp('No Model File...');
    rbf=createRBFNet(DimX,NumHid,DimY,1,1);    
end
plotU=zeros(RunNum,1);
plotY=zeros(RunNum,1);

model.ddy=0;
model.dy=0;
model.y=0;

figure(1);

num=1;

if ( exist('Data.mat','file')==2 )% 判断文件知否存在
    load 'Data.mat'
else
    for j=1:lyt
        
        model.ddy=0;
        model.dy=0;
        model.y=0;
        Se=0;
        olde=0;
        for i=1:RunNum
            
            e=yt(j)-model.y;
            de=(e-olde)/dt;
            olde=e;
            Se=Se+e*dt;
            
            X(:,num)=[e;Se;de];
            u=yRBFnet(rbf,X(:,num));
            model=demoModel(model,u,dt);
            Yt(num)= yt(j);
            
            for k=1:SingleTrainTime
                [rbf,f]=rbfTrain(rbf,X(:,num),Yt(num));
            end
            
            plotY(i,:)=model.y;
            plotU(i,:)=u;
            
            num=num+1;
            clf;
            
            plot(plotU);hold on;
            plot([0;plotY]);hold on;
            %    plot(yT-plotY);hold on;
            
            drawnow;
        end
        
    end
    legend('RBF输出','控制对象输出');
end

%% 批量训练
disp('批量训练');
%{%}
F=zeros(RunNum*lyt,1);
figure(3);
for i=1:BatTrainNum
    
%     [rbf,f]=rbfTrain(rbf,X,Yt);
    F(i)=f;
    clf;
    plot(F);hold on;
    axis([0 100 0 600]);
    drawnow;
end

save rbfTrained.mat rbf;


% net=newrb(X,Yt,0,1,300,100);
%{
%}

%% 测试


model.ddy=0;
model.dy=0;
model.y=y0;

testNum=testNum/dt;
rbfY=zeros(testNum,1);
U=zeros(testNum,1);
Se=0;
olde=0;
for t=1:testNum
    
    e=rbfyT-model.y;
    Se=Se+e*dt;
    de=(e-olde)/dt;
    olde=e;
    x=[ e;Se;de];
    u=yRBFnet(rbf,x);
    U(t)=u;
    model=demoModel(model,u,dt);
    rbfY(t)=model.y;
end
figure(2);
plot([y0; rbfY]);hold on;
% plot(ones(length(rbfY),1)*rbfyT);hold on;
plot(U,'marker','o','markersize',1);hold on;
plot(ones(testNum,1)*rbfyT);hold on;
legend('控制对象输出','RBF输出','期望');

% plot(plotr-U,'marker','.','markersize',1);hold on;