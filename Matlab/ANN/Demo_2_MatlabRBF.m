%% ����RBF�����磬��Matlab���RBF������ع�һ������f=sin(x)
%% ˵��

%% ����
X=0:0.01:pi*2;
Yt=sin(X)*3;

%% ���� ��ѵ��
net=newrb(X,Yt);

%% ����
testY=sim(net,testX);

figure(1);
plot(testX,testY);hold on;
plot(X,Yt,'color','g');hold on;
