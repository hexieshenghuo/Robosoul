%% ���嶯��ѧ���Գ���

clear;

%% �������ģ��
rm=rmLoadModel('RigidModel_1.m');

w=pi/3;% ���ٶȷ�ֵ
r=0.2;  % Բ���˶��뾶
m=1;  % ��������
 
Type=10.2; %% ��Type=0 �������������ת��������������ֱ���˶�
        % ��Type=1 �������������ת��������������Բ���˶�
F1=[0;-r*w^2;0]*Type; % 
rm.F=[F1];  % ������������ϵ����

rm.dt=0.0001; % ����ʱ��

Rz=Rot(-pi/2,'z',3);

rm.W_w=[0;0;-w]*0;
rm.W_b=[0;0;-w]*1;
  
rm.V_w=[w*r;0;0];
rm.V_b=[w*r;0;0]*10; 

N=60000;  %ѭ������

P=[];   % ����������ȫ������ϵ�¹켣
Vb=[];
Vw=[];

s=1;
f=r*w^2*s*1.6;
P=zeros(3,N);

tic;
for i=1:N
    F=f*Rot(-pi/2,'z',3)*rm.V_b;
    rm.F=[F];
    rm=rmUpdate(rm);   
    P(:,i)=rm.P;
end

time=toc;
disp(time);
    
figure(1);
plot(P(1,:),P(2,:));
axis equal;


figure(2);
plot(P(1,:),'color','r');hold on;
plot(P(2,:),'color','b');hold on;

axis([-0 N -18 8 ]);

%{
subplot(3,1,2);
plot(Vb(1,:),'r');hold on;
plot(Vb(2,:),'k');hold on;
plot(Vb(3,:),'g');hold on;

subplot(3,1,3);
plot(Vw(1,:),'r');hold on;
plot(Vw(2,:),'k');hold on;
plot(Vw(3,:),'g');hold on;
%}