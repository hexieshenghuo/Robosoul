%% RBF 学习控制 算法试验 3
%% 说明
%% 建立一个RBF控制器，测试步骤如下
%%    1）
%%
%%

%% ---时间周期
SingleRunTime=0.8;         % 一个初始条件的运行时间3s
dt=0.02;                 % 采样时间
SingleRunNum= SingleRunTime/dt;      % 运行次数
BatTrainNum=1;          %训练次数

%% ---控制数据
yTInterval=0.1;             % 控制期望的间隔
MaxyT=9;                    % 最大控制期望
MinyT=3;                    % 最小控制期望
yT=MinyT:yTInterval:MaxyT;  % 控制期望
RunNum=length(yT);          % 不同期望的运行次数
TestRumTime=3.6;
TestRunNum=TestRumTime/dt;
TestYt=2.5;                 % 测试的控制期望

%% ---PID
Kp=36;
Ki=0.6;
Kd=0.6;

%% ---RBF参数
DimX=3; % [dy y yT];
NumHid=256;
DimY=1;

% rbf=createRBFNet(DimX,NumHid,DimY);

%% ---训练数据
X=zeros(DimX,RunNum*SingleRunNum);
Yt=zeros(DimY,RunNum*SingleRunNum);

%% ---控制运行
DataFileName='Data_9.mat';
if ( exist(DataFileName,'file')==2 )% 判断文件知否存在
    load 'Data_9.mat'
else
    disp('No Model Data File...');
    
    num=1;
    figure(1);
    plotTime=(0:SingleRunNum-1)*dt;
    plotTime=plotTime.';
    
    for i=1:RunNum
        model.ddy=0;
        model.dy=0;
        model.y=0;
        
        plotY=zeros(1,SingleRunNum);
        plotU=zeros(1,SingleRunNum);
        
        olde=0;
        Se=0;
        for j=1:SingleRunNum
            
            % ---数据
            
            X(:,num)=[model.dy;model.y;yT(i)];
            
            plotY(j)=model.y;
            
            % ---计算控制输出
            e=yT(i)-model.y;
            de=(e-olde)/dt;
            Se=Se+e*dt;
            olde=e;
            
            u=pidController( Kp,Ki,Kd ,e,Se,de);
            u=max(-60,min(u,60));
            Yt(:,num)=u;
            
            % ---更新模型
            model=demoModel(model,u,dt);
            
            num=num+1;
            
            % ---绘图
            plotU(j)=u;
            clf;
            plot(plotTime,plotY);hold on;
            %       plot(plotTime,plotU);hold on;
            drawnow;
            
        end
    end
    save Data_9.mat X Yt;
end


%% ---批量训练
disp('批量训练');
ModelFileName='rbfTrained_9.mat';
if ( exist(ModelFileName,'file')==2 )% 判断文件知否存在
    load 'rbfTrained_9.mat'
else
    disp('No Model File...');
    rbf=createRBFNet(DimX,NumHid,DimY,1,1);
    [id ,C]=kmeans(X.',rbf.numHid);
    rbf.C=C;
end
F=zeros(BatTrainNum,1);
figure(2);
for i=1:BatTrainNum
    
   [rbf,f]=rbfTrain(rbf,X,Yt);
    F(i)=f;
    clf;
    plot(F);hold on;
    %axis([0 100 0 600]);
    drawnow;
end

save rbfTrained_9.mat rbf;

% RBF=newrb(X,Yt,0,1,500);
load 'rbf.mat';

%% ---测试

model.ddy=0;
model.dy=0;
model.y=0;
plotTestY=zeros(1,TestRunNum);
plotTestYt=ones(1,TestRunNum)*TestYt;
for i=1:TestRunNum
    
    r=sim(RBF,[model.dy;model.y;TestYt]);
    u=yRBFnet(rbf,[model.dy;model.y;TestYt]);
    model=demoModel(model,u,dt);
    plotTestY(:,i)=model.y;
end

figure(3);
plot(plotTestY);hold on;
plot(plotTestYt);hold on;