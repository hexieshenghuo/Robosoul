%m342z.m    2�����Զ�̬ϵͳ��ʶ������ϵͳy(k)+0.2y(k-1)=0.5u(k-1)
%           ����DTNN(����Ӧ������Ԫ+TDL)Ӧ��
%           ���������߱�ʶ
clear all;
close all;

%----��ʼ����
K=90;
a=0.25               ;%ѵ������
w=zeros(1,2);
w1=zeros(K,2);
yi=zeros(K,1);
v=(rand(K,1)-0.5)/20 ;%����
e=yi;
E=yi;

u=prbs(4,K,4,3,0,0) ;%ϵͳ����ʶ������
num=[0 0.5];
den=[1 0.2];
y=dlsim(num,den,u);
z1=[y u'];
figure(1);
idplot2(z1,1:K),pause ;%��ϵͳ����ʶ������

%----ϵͳ��ʶ
for k=2:K
    z(k)=y(k)+v(k);
    hsp=[-z(k-1) u(k-1)]'  ;%������Ԫ����
    yi(k)=w*hsp            ;%��ʶ�����
    e(k)=z(k)-yi(k)        ;%��ʶ���
    E(k)=(1/2)*e(k)^2 ;
    b=(hsp'*hsp)^0.5;
    w=w+a*e(k)*hsp'/b      ;%���Ʋ�����Ȩϵֵ������
    w1(k,1:2)=w;                                                 
end

 figure(2);
plot(y);hold on;plot(yi,'m');
        title('��������ϵͳ���z(k)����ʶ�����yi(k)','color','r');
        xlabel('(b)    k'),pause
figure(3) ;
plot(w1);ylabel('���Ʋ����������� W(k)','color','r','fontsize',13);
         xlabel('(c)     k'),pause
            
figure(4);         
plot(E);ylabel('Ŀ�꺯��E(k)','color','r','fontsize',13);
        xlabel('(d)    k');
 w1(90,:)                   %�۲���ƵĲ���

      
