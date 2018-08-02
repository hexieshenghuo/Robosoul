%% Jacobian轨迹生成测试程序
% theta=[-pi/2 pi/2 -pi/3 -pi/3 pi/3 pi/4]';
theta=[pi/4 -pi/4 pi/4 -pi/4  pi/4 -pi/4]';
P=[0 0 0 1]'
DH=[pi/2 0 60 0; -pi/2 0 60 0; pi/3 0 60 0; pi/3 0 60 0;pi/3 0 60 0; pi/3 0 60 0];
[N,col]=size(DH);
DH=updateDH(DH,theta);
Model=GetArmModel_2(DH,P);

% Model2=GetArmModel(DH,[0 0 30 1]');
% DrawComponent(Model2.ShowComponent);

%% 轨迹生成
dt=10;%100ms
T=500;%3000ms
da=pi/180*5;
R=9;
Traj=[];
for t=0:dt:T   
    clf;
    Vel_B=[-0.2 -0.1 0 0 0 0]';
    bJa=BJA(Model.T{N});
    
%   Vel_E=[0 -0.2 0 0 0 0]';
%    Vel_E=[MR(Model.T{N}) zeros(3);zeros(3) MR(Model.T{N})]*Vel_B;
%    Vel_E=MR(Model.T{N}) *Vel_B;
%   Vel_E=bJa(1:3,1:3)*Vel_B;
    Vel_E=bJa*Vel_B;
    
    Jaco=JacobianMat(Model.A);
    subJaco=Jaco(1:3,1:N);
%     Jaco=subJaco;
    dq= pinv(Jaco)*Vel_E; %关节速度
    disp(dq);
    
    DH(1:N,1)=DH(1:N,1)+dq*dt;
    Model=GetArmModel_2(DH,P);
    
    matT=Model.T{N};
    Traj=[Traj matT(1:3,4)];
    X=Traj(1,:);
    Y=Traj(2,:);
    Z=Traj(3,:);
    plot3(X,Y,Z);
    DrawComponent(Model.ShowComponent);
    SetShowState([-200,280,-280,280,-30,90]);
    drawnow;
    pause(0.1);
% hold on;
end