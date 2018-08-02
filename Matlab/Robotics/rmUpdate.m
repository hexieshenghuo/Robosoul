%% 更新刚体动力学模型
%% 
function [ rm ] = rmUpdate( rm )

%{ 
   %%具体函数
   %% 力与力矩
   rm=rmSumForce(rm);
   rm=rmSumTorque(rm);

   %% 加速度
   rm.Acc_b=(rm.SumF - cross( rm.W_b, rm.m*rm.V_b) )/rm.m;
   rm.Omi_b=rm.I\(rm.SumT - cross( rm.W_b, rm.I*rm.W_b) ); 
   
   rm.W_b=rm.W_b + rm.dt*rm.Omi_b; % *rm.K.'
   rm.V_b=rm.V_b + rm.dt*rm.Acc_b; %*rm.K.'
 
   
   %% 更新速度

   %% W_w
   rm.W_w=rm.R*rm.W_b;
   
   %% V_w
   rm.V_w=rm.R*rm.V_b;
   
   %% P
   rm.P=rm.P + rm.dt*rm.V_w;%   
  
   %% 欧拉角
   rm.Je_b=EulerJacobian(rm.Euler,'xyz','b');
   rm=rmdEuler(rm);
   rm=rmEuler(rm);
  
   %% R
   %rm=rmR(rm); 
   rm=rmK(rm);
   rm.R=rm.R*rm.K;
%}
   %% 动力学
   rm=rmDynamics(rm);
   %% 运动学
   rm=rmKinematics(rm);

end