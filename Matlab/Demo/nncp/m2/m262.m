%m262.m                 ��˹RBF: һά����ά
clear all;
close all;

%----һά��˹RBF
x=-10:1/5:10;
R1=exp(-x.^2);
R2=exp(-(x/3).^2);

u=-10:1/5:10;
R3=exp(-(u+5).^2);
R4=exp(-((u-2)/3).^2);

%----��ά��˹RBF
[u1,u2]=meshgrid(-10:0.5:10);
z=exp(-((u1/2).^2+((u2-2)/4).^2));

figure(1);
subplot(221),plot(x,R1,'r',x,R2,'b');
             ylabel('R1   R2  (����x)');xlabel('x');
             title('һά');
subplot(222),plot(u,R3,'r',u,R4,'b');
             ylabel('R3   R4  (����u)');xlabel('u');
             title('һά');
subplot(223);d=mesh(u1,u2,z);hold on;
             xlabel('u1');ylabel('u2');zlabel('R');grid;
             title('��ά');grid off        
subplot(224);contour(u1,u2,z);xlabel('u1');
             ylabel('u2');title('��ά');,pause

figure(2);
subplot(221),plot(x,R1,'r',x,R2,'b');
             ylabel('R1   R2  (����x)');xlabel('x');
             title('һά');
subplot(222),plot(u,R3,'r',u,R4,'b');
             ylabel('R3   R4  (����u)');
             xlabel('u');title('һά');
figure(3);
d=mesh(u1,u2,z);hold on;
             xlabel('u1');ylabel('u2');
             zlabel('R');title('��ά������u1��u2');grid;  
 figure(4);            
contour(u1,u2,z);xlabel('u1');ylabel('u2');title('��ά'),pause