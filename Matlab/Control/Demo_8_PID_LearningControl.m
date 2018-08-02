%% PID 学习控制 算法试验 3

yt=0:1:18;
lyt=length(yt);
RunTime=0.5;
testNum=28;
SingleTrainTime=3;
rbfyT=6.8;
y0=0;

dt=0.02;
RunNum=RunTime/dt;


plotU=zeros(RunNum,1);
plotY=zeros(RunNum,1);

model.ddy=0;
model.dy=0;
model.y=0;

figure(1);

num=1;

Kp=3;
Ki=0.1;
Kd=0.09;
K=[Kp;Ki;Kd];
lr=3.0e-12;
lamda=1;

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
            
            u=pidController(K(1),K(2),K(3),e,Se,de);
            model=demoModel(model,u,dt);

            for k=1:SingleTrainTime
                y=model.y;
                g=-6*lamda^2*exp(-(y - yt(j)))*(exp(-(y - yt(j))) - 1)*(y - yt(j))^2;
                
                K=K-lr*g;
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
    legend('PID输出','控制对象输出');
end

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
    u=pidController(K(1),K(2),K(3),e,Se,de);
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