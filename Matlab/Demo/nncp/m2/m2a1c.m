%m2a1c.m             ����CHNN--3����Ԫ   ʵ����֤�����������  
clear all;
close all;
v=[1 1;-1 1;-1 -1]                         ;%3ά�ռ������ȶ�ƽ���
axis([-1 1 -1 1 -1 1]);
set(gca,'box','on');axis manual;hold on;
plot3(v(1,:),v(2,:),v(3,:),'r*')           ;%�������ȶ�ƽ���
      xlabel('v(1)');ylabel('v(2)');
      zlabel('v(3)');title('CHNN��3ά״̬�ռ�'),pause

net=newhop(v)                                  ;%���CHNN
  color='rgbmy';
 for i=1:5
a1={rands(3,1)}                                ;%5�������ʼ��                                                            
y1=sim(net,{1 10},{},a1);
record=[cell2mat(a1) cell2mat(y1)];
start=cell2mat(a1);
hold on;plot3(start(1,1),start(2,1),start(3,1),'bx',...
    record(1,:),record(2,:),record(3,:),color(rem(i,5)+1));
end                                           %5����ʼ����������                                        