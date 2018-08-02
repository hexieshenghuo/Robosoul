%m265a.m          ��˹RBFNN,�ƽ������Ժ�����  �ú���newrb(u,d,eg,sc)
clear all;
close all;

%----��������Ժ���d=f(u)
u=-3:0.1:3;
q1=radbas(u);
q2=radbas(u-1.5);
q3=radbas(u+2);
q31=0.5*q3;
d=q1+q2+q31;

figure(1);
plot(u,q1,'b',u,q2,'b',u,q3,'b');
           ylabel('q1   q2   q3');xlabel('u');axis([-3 3 0 1.4]);
           text(-2,1.05,'q3');text(0,1.05,'q1');text(1.4,1.05,'q2'),pause
figure(2);          
plot(u,q1,'b',u,q2,'b',u,q31,'b',u,d,'r');
           ylabel('d   q1   q2   0.5*q3');xlabel('u');
           text(0.5,1.2,'d=q1+q2+0.5*q3');text(-2.2,0.4,'0.5*q3');text(0,1.05,'q1');
           text(1.4,1.05,'q2');text(-2.7,1.2,'��������Ժ���d=f(u)'),pause
eg=0.02;
sc=1;
net=newrb(u,d,eg,sc)     ;%���RBFNN
y=sim(net,u)             ;%RBFNN�����

figure(3);
plot(u,d,'bo',u,y,'r*');ylabel('�����Ժ���d=f(u)  �������y');
                        xlabel('����������u'),pause
w1=net.iw{1,1}            %�۲��������           
b1=net.b{1}
w2=net.lw{2,1}
b2=net.b{2}

