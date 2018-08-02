%m451.m            ��PD����:
%                  ������� y(k)=0.8sin[y(k-1)]+1.2u(k-1)
clear all;
close all;

%----��ʼ����
i=80;
r=ones(i,1)                     ;%�赥λ��Ծ����
v=zeros(i,1);v(40,1)=0.1        ;%���Ŷ�
y=zeros(i,1);u=y;ng=y;
e=y;e1=e;e2=e;
llw=zeros(i,1);
a1=0.1;                         ;%��ѵ������
a2=0.08;

net=newff([-2 2],[10,1],{'tansig','purelin'})  ;%����BPģ��N1,10,1
iw=(rand(10,1)-0.5)/10                         ;%���õĳ�ʼȨϵֵ
net.iw{1,1}=iw;
lw=net.lw{2,1}/10;                                            
wpd=[0.6;0.3];                                 ;%PD��������ʼ�� 
dwpd=zeros(2,1);

%----PD����ϵͳ
for k=2:i 
 e(k)=r(k)-y(k); 
 u(k)=wpd(1)*e(k)+wpd(2)*[e(k)-e(k-1)]+v(k)    ;%���������    
 y(k)=0.8*sin(y(k-1))+1.2*u(k-1)+v(k)          ;%����ϵͳ���
    ya=y(k-1);                                 ;%��ʶ������
x=(net.iw{1,1}+net.b{1})*ya                    ;%��ʶ������״̬
o=tansig(x)                                    ;%��ʶ���������
ng=(net.lw{2,1}+net.b{2})*o                   ;
    yi(k)=ng+1.2*u(k-1)                       ;%��ʶ�����yi(k)
       e1(k)=y(k)-yi(k)                       ;%��ʶ��� 
       
%----��ʶ��ѵ��
lw=net.lw{2,1}+a2*e1(k)*o';
b2=net.b{2}+a2*e1(k);
net.lw{2,1}=lw;
net.b{2}=b2;
iw=net.iw{1,1}+a1*e1(k)*lw*dtansig(x,o)*ya;
net.iw{1,1}=iw;
b1=net.b{1}+a1*e1(k)*lw*dtansig(x,o);
net.b{1}=b1;
llw(k)=lw(1,1);

%----PD������ѵ��
  e2(k)=r(k)-yi(k);
  dwpd=a1*1.2*e2(k)*[e(k);e(k)-e(k-1)];
  wpd=wpd+dwpd;      
   end
   
figure; 
subplot(221),plot(y,'r');hold on;plot(r,'b');hold on;
             plot(v,'k');axis([0 80 -0.2 2]);
                         ylabel('����ϵͳ����r�����y');
             text(30,0.3,'�Ŷ�v(k)');
subplot(223),plot(u,'b');ylabel('���������u'); xlabel('k');        
subplot(222),plot(y,'r');hold on;
             plot(yi,'b--');ylabel('ϵͳ����ʶ�����:y  yi');
subplot(224),plot(llw,'r');ylabel('һȨֵ��������lw(1)');
                            xlabel('k');
