%m254.m     逼近非线性函数d=f(u)=exp(-1.9(u+0.5))sin(10u)             
clear all;
close all;

u=-0.5:0.05:0.45               ;%输入样本集
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u)                ;%输出样本集：非线性函数d
net=newff(minmax(u),[3,1],{'tansig','purelin'},'trainlm');%设计网络结构N1,3,1
%w01=net.iw{1,1}               %观测BP网1-2层的初始权值、阈值
%b01=net.b{1}
%w02=net.lw{2}                 %观测2-3层的初始权值、阈值
%b02=net.b{2}

figure(1);
plot(u,d,'bo');ylabel('输出样本集d=f(u)','color','r','fontsize',13);
               xlabel('输入样本集u','color','r','fontsize',13) ,pause
figure(2);
net=train(net,u,d);               %网络训练
%w1=net.iw{1,1}                   %观测BP学习后的权系值
%b1=net.b{1}                      
%w2=net.lw{2}                     
%b2=net.b{2}                                          
y=sim(net,u);                    %网络输出
figure(3);
plot(u,d,'bo',u,y,'r*');ylabel('输出样本集d(o)  网络输出y(*)','color','r','fontsize',13); 
                        xlabel('输入样本集u') ,pause

u1=-0.48:0.05:0.47               ;%测试输入集
d1=-1.9*(u1+0.5);
d1=exp(d1);
d1=d1.*sin(10*u1);                ;%测试数据集    
y1=sim(net,u1); 

figure(4);
plot(u1,y1,'go',u1,d1,'r*');ylabel('测试数据集d1(*)  网络输出y1(o)','color','r','fontsize',13); 
                            xlabel('测试输入集u1','color','r','fontsize',13) ;
[d' y']
