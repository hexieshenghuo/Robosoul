%m221.m       神经元的10个作用函数  +  导数
clear all;
close all;

%---神经元的1~2个作用函数  +  导数
x=-5:0.01:5;
y1=poslin(x)         ;%正线性函数
yy1=dposlin(x,y1)    ;%         导数
y2=purelin(x)        ;%线性函数
yy2=dpurelin(x,y2)   ;%        导数
x1=[-2 2];x2=[0 0];x3=[-5 5];y01=[0 0];y02=[-2 2];

figure(1);
subplot(221),plot(x,y1,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y1=f(x)');title('正线性函数');axis([-2 2 -2 2]);
subplot(222),plot(x,y2,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y2=f(x)');title('线性函数');axis([-2 2 -2 2]);                                                                 
subplot(223),plot(x,yy1,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy1');xlabel('x');title('正线性函数导数');axis([-2 2 -1.5 1.5]);
subplot(224),plot(x,yy2,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy2');xlabel('x');title('线性函数导数');axis([-2 2 -1.5 1.5]),pause
             
%---神经元的3~4个作用函数  +  导数 
y3=satlin(x)          ;%饱和线性函数
yy3=dsatlin(x,y3)     ;%             导数
y4=satlins(x)         ;%对称饱和线性函数
yy4=dsatlins(x,y4)    ;%             导数  

 figure(2);
subplot(221),plot(x,y3,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y3=f(x)');title('饱和线性函数');axis([-2 2 -2 2]);
subplot(222),plot(x,y4,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y4=f(x)');title('对称饱和线性函数');axis([-2 2 -2 2]);                                                                 
subplot(223),plot(x,yy3,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy3');xlabel('x');title('饱和线性函数导数');axis([-2 2 -1.5 1.5]);
subplot(224),plot(x,yy4,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy4');xlabel('x');title('对称饱和线性函数导数');
                           axis([-2 2 -1.5 1.5]),pause            

%---神经元的5~6个作用函数
y5=hardlim(x)        ;%非对称阶跃函数
yy5=dhardlim(x,y5)   ;%              导数
y6=hardlims(x)       ;%对称阶跃函数
yy6=dhardlim(x,y6)   ;%              导数

figure(3);
subplot(221),plot(x,y5,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y5=f(x)');title('非对称阶跃函数');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y6,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y6=f(x)');title('对称阶跃函数');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy5,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy5');xlabel('x');title('非对称阶跃函数导数');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy6,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy6');xlabel('x');title('对称阶跃函数导数');
                           axis([-5 5 -1.5 1.5]),pause
                                          
%---神经元的7~8个作用函数                                 
y7=logsig(x);         ;%非对称Sigmoid函数
yy7=dlogsig(x,y7)     ;%                 导数
y8=tansig(x)          ;%对称Sigmoid函数
yy8=dtansig(x,y8)     ;%                 导数

figure(4);
subplot(221),plot(x,y7,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y7=f(x)');title('非对称Sigmoid函数');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y8,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y8=f(x)');title('对称Sigmoid函数');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy7,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy7');xlabel('x');title('非对称Sigmoid函数导数');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy8,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy8');xlabel('x');title('对称Sigmoid函数导数');
                                          axis([-5 5 -1.5 1.5]),pause
 
 %---神经元的9~10个作用函数  +  导数
 y9=radbas(x)         ;%RBF函数
yy9=dradbas(x,y9)     ;%        导数
y10=tribas(x)         ;%三角基函数
yy10=dtribas(x,y10)   ;%        导数 

figure(5);
subplot(221),plot(x,y9,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y9=f(x)');title('高斯RBF函数');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y10,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y10=f(x)');title('三角基函数');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy9,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy9');xlabel('x');title('高斯RBF函数导数');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy10,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy10');xlabel('x');title('三角基函数导数');
                                          axis([-5 5 -1.5 1.5]),pause