%m2a1b.m             ����CHNN---2��Ԫ����֪������̬(��άƽ��)          
clear all;
close all;

%--6�������̬  ������������̬ 
v=[1 -1;-1 1]                      ;%2άƽ��������̬
net=newhop(v)                      ;%�������
ai=v; 
y=sim(net,2,[],ai);                 %������Ƶ�����
v
y
plot(v(1,:),v(2,:),'r*');axis([-1.1 1.1 -1.1 1.1]);
   hold on,pause
   title('ÿ������������̬�Ĺ��̣���6�㣩')
color='rgbmy';
for i=1:6
a1={rands(2,1)} ;                          ;
[y1,pf,af]=sim(net,{1 26},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1);hold on,pause
plot(start(1,1),start(2,1),'bo');hold on,pause
plot(record(1,:),record(2,:),color(rem(i,5)+1));%����������
end
