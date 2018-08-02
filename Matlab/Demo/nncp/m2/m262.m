%m262.m                 高斯RBF: 一维、二维
clear all;
close all;

%----一维高斯RBF
x=-10:1/5:10;
R1=exp(-x.^2);
R2=exp(-(x/3).^2);

u=-10:1/5:10;
R3=exp(-(u+5).^2);
R4=exp(-((u-2)/3).^2);

%----二维高斯RBF
[u1,u2]=meshgrid(-10:0.5:10);
z=exp(-((u1/2).^2+((u2-2)/4).^2));

figure(1);
subplot(221),plot(x,R1,'r',x,R2,'b');
             ylabel('R1   R2  (变量x)');xlabel('x');
             title('一维');
subplot(222),plot(u,R3,'r',u,R4,'b');
             ylabel('R3   R4  (变量u)');xlabel('u');
             title('一维');
subplot(223);d=mesh(u1,u2,z);hold on;
             xlabel('u1');ylabel('u2');zlabel('R');grid;
             title('二维');grid off        
subplot(224);contour(u1,u2,z);xlabel('u1');
             ylabel('u2');title('二维');,pause

figure(2);
subplot(221),plot(x,R1,'r',x,R2,'b');
             ylabel('R1   R2  (变量x)');xlabel('x');
             title('一维');
subplot(222),plot(u,R3,'r',u,R4,'b');
             ylabel('R3   R4  (变量u)');
             xlabel('u');title('一维');
figure(3);
d=mesh(u1,u2,z);hold on;
             xlabel('u1');ylabel('u2');
             zlabel('R');title('二维：变量u1、u2');grid;  
 figure(4);            
contour(u1,u2,z);xlabel('u1');ylabel('u2');title('二维'),pause