%m2a1b.m             构建CHNN---2神经元，已知两个稳态(二维平面)          
clear all;
close all;

%--6个随机初态  收敛到两个稳态 
v=[1 -1;-1 1]                      ;%2维平面两个稳态
net=newhop(v)                      ;%设计网络
ai=v; 
y=sim(net,2,[],ai);                 %检验设计的网络
v
y
plot(v(1,:),v(2,:),'r*');axis([-1.1 1.1 -1.1 1.1]);
   hold on,pause
   title('每个点收敛到稳态的过程（共6点）')
color='rgbmy';
for i=1:6
a1={rands(2,1)} ;                          ;
[y1,pf,af]=sim(net,{1 26},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1);hold on,pause
plot(start(1,1),start(2,1),'bo');hold on,pause
plot(record(1,:),record(2,:),color(rem(i,5)+1));%画收敛过程
end
