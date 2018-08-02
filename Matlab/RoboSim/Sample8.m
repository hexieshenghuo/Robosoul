%% 

T=eye(4);
TA=T;
dt=10;%100ms
r=5;

W_B=[0 0 0.2*pi/100]';%相对自身坐标系的微分速度
Vel_B=[W_B(3) 0 0]';%相对自身坐标系的微分角速度

XB=[];%
YB=[];%

XA=[];%
YA=[];%   

SumX=[0];%
SumY=[0];%

dVel=Vel_B*dt;
da=W_B(3)*dt; %微分角度

for t=0:1:100
    clf;
    J=BJA(T);
    %相对坐标微分运动
    T=T*Trans([dVel;1])*KRot([0 0 1],da);
    P=Vp(T);
    XB=[XB P(1)];
    YB=[YB P(2)];

    % 绝对坐标
    Vel=inv(J)*[Vel_B;W_B];
    Vel=Vel*dt;
   
    velA=MR(T)*Vel_B;
    SumX=[SumX SumX(end)+Vel(1)];
    SumY=[SumY SumY(end)+Vel(2)];
    
    TA=Trans([Vel(1:3);1])*KRot([0 0 1],Vel(6))*T;
   
    P=Vp(TA);
    XA=[XA P(1)];
    YA=[YA P(2)];
    
    subplot(3,1,1);
    plot(XB,YB);
    SetShowState(1.5);
    
%   drawnow;
    subplot(3,1,2);
    plot(XA,YA);
    SetShowState(1.5);
    
    subplot(3,1,3);
    plot(SumX,SumY);
    SetShowState(1.5);
    
    drawnow;
end