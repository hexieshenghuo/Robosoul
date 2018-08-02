%m341z.m    2�����Զ�̬ϵͳ��ʶ��
%           ����ϵͳ: y(k)-1.5y(k-1)+0.7y(k-2)=u(k-1)+0.5u(k-2)
%           ����DTNN(����Ӧ������Ԫ+TDL)Ӧ��
%           ���������߱�ʶ
clear all;
close all;

%----��ʼ����
i=90;
a=0.25               ;%ѵ������
w=zeros(1,4);
w1=zeros(i,4);
yi=zeros(i,1);
e=yi;
E=yi;
u=prbs(4,90,4,3,0,0)  ;%ϵͳ����ʶ������
num=[0 1 0.5];
den=[1 -1.5 0.7];
y=dlsim(num,den,u);
z=[y u'];
figure(1);
idplot2(z,1:90),pause   ;%��ϵͳ����ʶ������

%----ϵͳ��ʶ
for k=3:i
    hsp=[-y(k-1) -y(k-2) u(k-1) u(k-2)]' ; %������Ԫ����
    yi(k)=w*hsp                          ; %��ʶ�����
    e(k)=y(k)-yi(k)                      ; %��ʶ���
    E(k)=(1/2)*e(k)^2 ;
    b=(hsp'*hsp)^0.5;
    w=w+a*e(k)*hsp'/b                    ;%���Ʋ�����Ȩϵֵ������
    w1(k,1:4)=w;                                                 
end

 figure(2);
plot(y);hold on;plot(yi,'m');
             ylabel('ϵͳ����ʶ����� y(k)  yi(k)','color','r','fontsize',13) 
             xlabel('(b)    k'),pause             
figure(3) ;
plot(w1);axis([0 90 -2 1.2]);
         ylabel('���Ʋ����������� W(k)','color','r','fontsize',13);
         xlabel('(c)     k'),pause         
figure(4)                               ;%��Ŀ�꺯��
plot(E);ylabel('Ŀ�꺯��E(k)','color','r','fontsize',13);
        xlabel('(d)    k');        
 w=w1(90,:)                             %�۲���ƵĲ���

      
