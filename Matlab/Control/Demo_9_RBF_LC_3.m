%% RBF ѧϰ���� �㷨���� 3
%% ˵��
%% ����һ��RBF�����������Բ�������
%%    1��
%%
%%

%% ---ʱ������
SingleRunTime=0.8;         % һ����ʼ����������ʱ��3s
dt=0.02;                 % ����ʱ��
SingleRunNum= SingleRunTime/dt;      % ���д���
BatTrainNum=1;          %ѵ������

%% ---��������
yTInterval=0.1;             % ���������ļ��
MaxyT=9;                    % ����������
MinyT=3;                    % ��С��������
yT=MinyT:yTInterval:MaxyT;  % ��������
RunNum=length(yT);          % ��ͬ���������д���
TestRumTime=3.6;
TestRunNum=TestRumTime/dt;
TestYt=2.5;                 % ���ԵĿ�������

%% ---PID
Kp=36;
Ki=0.6;
Kd=0.6;

%% ---RBF����
DimX=3; % [dy y yT];
NumHid=256;
DimY=1;

% rbf=createRBFNet(DimX,NumHid,DimY);

%% ---ѵ������
X=zeros(DimX,RunNum*SingleRunNum);
Yt=zeros(DimY,RunNum*SingleRunNum);

%% ---��������
DataFileName='Data_9.mat';
if ( exist(DataFileName,'file')==2 )% �ж��ļ�֪�����
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
            
            % ---����
            
            X(:,num)=[model.dy;model.y;yT(i)];
            
            plotY(j)=model.y;
            
            % ---����������
            e=yT(i)-model.y;
            de=(e-olde)/dt;
            Se=Se+e*dt;
            olde=e;
            
            u=pidController( Kp,Ki,Kd ,e,Se,de);
            u=max(-60,min(u,60));
            Yt(:,num)=u;
            
            % ---����ģ��
            model=demoModel(model,u,dt);
            
            num=num+1;
            
            % ---��ͼ
            plotU(j)=u;
            clf;
            plot(plotTime,plotY);hold on;
            %       plot(plotTime,plotU);hold on;
            drawnow;
            
        end
    end
    save Data_9.mat X Yt;
end


%% ---����ѵ��
disp('����ѵ��');
ModelFileName='rbfTrained_9.mat';
if ( exist(ModelFileName,'file')==2 )% �ж��ļ�֪�����
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

%% ---����

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