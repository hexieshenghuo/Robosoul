%m242.m         ������ԪӦ�ã�����(L2)�ƽ�
clear all;
close all;

u=[1 2 3 4 5]               ; %��֪��������
d=[2.0 4.3 5.7 8.2 9.5]     ; %        ���
net=newlind(u,d)            ; %���������Ԫ
y=sim(net,u)                ; %����:������u,����Ԫ���y

figure(1);
plot(u,d,'b*');ylabel('d');xlabel('u');
               text(2,9,'d/u (*) ��֪�������롢���'),pause
figure(2);
plot(u,d,'b*',u,y,'r+');ylabel('d      y');xlabel('u');
               text(2,9,'d/u (*) ��֪�������롢���');
               text(3,3,'y/u (+)  ������Ԫ���롢��� '),pause  
figure(3);
plot(u,d,'b*',u,y,'r+',u,y,'r--');ylabel('d      y');xlabel('u');
              text(2,9,'d/u (*) ��֪�������롢���');
              text(3,3,'y/u (+)  ������Ԫ���롢��� '),pause      
w=net.iw{1,1}                 %�۲�Ȩֵ����ֵ
b=net.b{1}                                              
w=-2:0.2:2;
b=-2:0.2:2;
es=errsurf(u,d,w,b,'purelin');
figure(4);
plotes(w,b,es) ,text(-4.3,2.2,'������漰�ȸ���');
