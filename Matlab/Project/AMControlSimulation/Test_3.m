%% ª˙–µ±€ Jacobian ≤‚ ‘
%%

AM=amLoadModel('amModelScript.m');

vel=[-0.01;-0.01;0.01];

Num=1000;
arm=AM.arm;
Pe=zeros(3,Num);

for i=1:Num
    [J,Jv]=arm.J_e2b(arm.Theta,arm.LinkLength);
    invJv=pinv(Jv);
    dtheta=invJv*vel;
    
    arm.Theta= arm.Theta + [arm.dt*dtheta;0];
    
    arm=armUpdatePose(arm,arm.Theta,eye(4));
    
    Pe(:,i)=armGetPe(arm);
   
end
X=Pe(1,:);
Y=Pe(2,:);
Z=Pe(3,:);
amDraw(AM);
SetShowState(0.5);
