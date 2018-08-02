%% 测试RBF神经网络，用RoboSoul里写的RBF神经网络回归一个函数f=sin(x)
%% 说明
Iteration=300; % 可以尝试3000次
X=0:0.01:pi*2;
Yt=sin(X)*3;

rbf =createRBFNet(1, 18 ,1);
[id ,C]=kmeans(X.',rbf.numHid);
rbf.C=C;
disp('Init OK');

testX=0:0.02:pi*2;

error=zeros(Iteration,1);

%{
   net=newrb(X,Yt);
%}

for i=1:Iteration
    [rbf,g]=rbfTrain(rbf,X,Yt);
    if norm(g)<0.01
        break;
    end
    error(i)=rbfBatErrorFun(rbf,X,Yt);
end

testY=zeros(1,length(testX));

for i=1:length(testX)
    testY(i)=yRBFnet(rbf,testX(i));
end

% testY=sim(net,testX);

figure(1);
plot(testX,testY);hold on;
plot(X,Yt,'color','g');hold on;

figure(2);
plot(error);hold on;
