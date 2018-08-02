%m254.m     �ƽ������Ժ���d=f(u)=exp(-1.9(u+0.5))sin(10u)             
clear all;
close all;

u=-0.5:0.05:0.45               ;%����������
d=-1.9*(u+0.5);
d=exp(d);
d=d.*sin(10*u)                ;%����������������Ժ���d
net=newff(minmax(u),[3,1],{'tansig','purelin'},'trainlm');%�������ṹN1,3,1
%w01=net.iw{1,1}               %�۲�BP��1-2��ĳ�ʼȨֵ����ֵ
%b01=net.b{1}
%w02=net.lw{2}                 %�۲�2-3��ĳ�ʼȨֵ����ֵ
%b02=net.b{2}

figure(1);
plot(u,d,'bo');ylabel('���������d=f(u)','color','r','fontsize',13);
               xlabel('����������u','color','r','fontsize',13) ,pause
figure(2);
net=train(net,u,d);               %����ѵ��
%w1=net.iw{1,1}                   %�۲�BPѧϰ���Ȩϵֵ
%b1=net.b{1}                      
%w2=net.lw{2}                     
%b2=net.b{2}                                          
y=sim(net,u);                    %�������
figure(3);
plot(u,d,'bo',u,y,'r*');ylabel('���������d(o)  �������y(*)','color','r','fontsize',13); 
                        xlabel('����������u') ,pause

u1=-0.48:0.05:0.47               ;%�������뼯
d1=-1.9*(u1+0.5);
d1=exp(d1);
d1=d1.*sin(10*u1);                ;%�������ݼ�    
y1=sim(net,u1); 

figure(4);
plot(u1,y1,'go',u1,d1,'r*');ylabel('�������ݼ�d1(*)  �������y1(o)','color','r','fontsize',13); 
                            xlabel('�������뼯u1','color','r','fontsize',13) ;
[d' y']
