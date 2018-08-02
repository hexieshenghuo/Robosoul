%m2a1c.m             构建CHNN--3个神经元   实验验证联想记忆能力  
clear all;
close all;
v=[1 1;-1 1;-1 -1]                         ;%3维空间两个稳定平衡点
axis([-1 1 -1 1 -1 1]);
set(gca,'box','on');axis manual;hold on;
plot3(v(1,:),v(2,:),v(3,:),'r*')           ;%画两个稳定平衡点
      xlabel('v(1)');ylabel('v(2)');
      zlabel('v(3)');title('CHNN的3维状态空间'),pause

net=newhop(v)                                  ;%设计CHNN
  color='rgbmy';
 for i=1:5
a1={rands(3,1)}                                ;%5个随机初始点                                                            
y1=sim(net,{1 10},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1);
hold on;plot3(start(1,1),start(2,1),start(3,1),'bx',...
    record(1,:),record(2,:),record(3,:),color(rem(i,5)+1));
end                                           %5个初始点收敛过程                                        