%m221.m       ��Ԫ��10�����ú���  +  ����
clear all;
close all;

%---��Ԫ��1~2�����ú���  +  ����
x=-5:0.01:5;
y1=poslin(x)         ;%�����Ժ���
yy1=dposlin(x,y1)    ;%         ����
y2=purelin(x)        ;%���Ժ���
yy2=dpurelin(x,y2)   ;%        ����
x1=[-2 2];x2=[0 0];x3=[-5 5];y01=[0 0];y02=[-2 2];

figure(1);
subplot(221),plot(x,y1,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y1=f(x)');title('�����Ժ���');axis([-2 2 -2 2]);
subplot(222),plot(x,y2,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y2=f(x)');title('���Ժ���');axis([-2 2 -2 2]);                                                                 
subplot(223),plot(x,yy1,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy1');xlabel('x');title('�����Ժ�������');axis([-2 2 -1.5 1.5]);
subplot(224),plot(x,yy2,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy2');xlabel('x');title('���Ժ�������');axis([-2 2 -1.5 1.5]),pause
             
%---��Ԫ��3~4�����ú���  +  ���� 
y3=satlin(x)          ;%�������Ժ���
yy3=dsatlin(x,y3)     ;%             ����
y4=satlins(x)         ;%�ԳƱ������Ժ���
yy4=dsatlins(x,y4)    ;%             ����  

 figure(2);
subplot(221),plot(x,y3,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y3=f(x)');title('�������Ժ���');axis([-2 2 -2 2]);
subplot(222),plot(x,y4,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('y4=f(x)');title('�ԳƱ������Ժ���');axis([-2 2 -2 2]);                                                                 
subplot(223),plot(x,yy3,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy3');xlabel('x');title('�������Ժ�������');axis([-2 2 -1.5 1.5]);
subplot(224),plot(x,yy4,'r','linewidth',2);line(x1,y01);line(x2,y02);
             ylabel('yy4');xlabel('x');title('�ԳƱ������Ժ�������');
                           axis([-2 2 -1.5 1.5]),pause            

%---��Ԫ��5~6�����ú���
y5=hardlim(x)        ;%�ǶԳƽ�Ծ����
yy5=dhardlim(x,y5)   ;%              ����
y6=hardlims(x)       ;%�Գƽ�Ծ����
yy6=dhardlim(x,y6)   ;%              ����

figure(3);
subplot(221),plot(x,y5,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y5=f(x)');title('�ǶԳƽ�Ծ����');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y6,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y6=f(x)');title('�Գƽ�Ծ����');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy5,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy5');xlabel('x');title('�ǶԳƽ�Ծ��������');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy6,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy6');xlabel('x');title('�Գƽ�Ծ��������');
                           axis([-5 5 -1.5 1.5]),pause
                                          
%---��Ԫ��7~8�����ú���                                 
y7=logsig(x);         ;%�ǶԳ�Sigmoid����
yy7=dlogsig(x,y7)     ;%                 ����
y8=tansig(x)          ;%�Գ�Sigmoid����
yy8=dtansig(x,y8)     ;%                 ����

figure(4);
subplot(221),plot(x,y7,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y7=f(x)');title('�ǶԳ�Sigmoid����');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y8,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y8=f(x)');title('�Գ�Sigmoid����');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy7,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy7');xlabel('x');title('�ǶԳ�Sigmoid��������');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy8,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy8');xlabel('x');title('�Գ�Sigmoid��������');
                                          axis([-5 5 -1.5 1.5]),pause
 
 %---��Ԫ��9~10�����ú���  +  ����
 y9=radbas(x)         ;%RBF����
yy9=dradbas(x,y9)     ;%        ����
y10=tribas(x)         ;%���ǻ�����
yy10=dtribas(x,y10)   ;%        ���� 

figure(5);
subplot(221),plot(x,y9,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y9=f(x)');title('��˹RBF����');axis([-5 5 -1.5 1.5]);
subplot(222),plot(x,y10,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('y10=f(x)');title('���ǻ�����');axis([-5 5 -1.5 1.5]);
subplot(223),plot(x,yy9,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy9');xlabel('x');title('��˹RBF��������');axis([-5 5 -1.5 1.5]);
subplot(224),plot(x,yy10,'r','linewidth',2);line(x3,y01);line(x2,y02);
             ylabel('yy10');xlabel('x');title('���ǻ���������');
                                          axis([-5 5 -1.5 1.5]),pause