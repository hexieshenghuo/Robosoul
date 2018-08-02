%% 测试RBF神经网络，用Matlab里的RBF神经网络回归一个函数f=sin(x)
%% 说明

%% 样本
X=0:0.01:pi*2;
Yt=sin(X)*3;

%% 创建 并训练
net=newrb(X,Yt);

%% 测试
testY=sim(net,testX);

figure(1);
plot(testX,testY);hold on;
plot(X,Yt,'color','g');hold on;
