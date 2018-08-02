%% Jacobian轨迹生成测试程序
theta=[0 0 0 0]';
P=[0 0 0 1]'
DH=[-pi/6 0 60 0; 0 0 60 -pi/2; pi/3 0 0 pi/2; 0 30 0 0];
[N,col]=size(DH);
DH=updateDH(DH,theta);
Model=getArmModel(DH,P);
DrawComponent(Model.ShowComponent);
hold on;

% Model2=GetArmModel(DH,[0 0 30 1]');
% DrawComponent(Model2.ShowComponent);

SetShowState([-100,180,-180,180,-190,190]);

%% 轨迹生成
dt=10;%100ms
T=500;%3000ms

Traj=[];
for t=0:dt:T   
    clf;
    Vel_B=[0 0 -0.1]';
    bJa=BJA(Model.T{4});
    
%    Vel_E=[0.1 0 0 0 0 0]';
  Vel_E=MR(Model.T{4})*Vel_B;
%       Vel_E=bJa(1:3,1:3)*Vel_B;
%       Vel_E=bJa*Vel_B;
    Jaco=JacobianMat(Model.A);
    subJaco=Jaco(1:3,1:N);
    dq= pinv(subJaco)*Vel_E; %关节速度
    
    DH(1:N,1)=DH(1:N,1)+dq*dt;
    Model=getArmModel(DH,P);
    
    matT=Model.T{N};
    Traj=[Traj matT(1:3,4)];
    X=Traj(1,:);
    Y=Traj(2,:);
    Z=Traj(3,:);
    plot3(X,Y,Z);
    DrawComponent(Model.ShowComponent);
    SetShowState([-10,180,-80,80,-90,90]);
    drawnow;
% hold on;
end