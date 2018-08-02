%% 更新刚体运动学
%% 
function [ rm ] = rmKinematics( rm )  
   
   %% W_w
   rm.W_w=rm.R*rm.W_b;
   
   %% V_w
   rm.Acc_w=rm.R*Sw(rm.W_b)*rm.V_b + rm.R*rm.Acc_b;% rm.K*  rm.K*
   rm.V_w=rm.R*rm.V_b;   %rm.K*
   
   %% P
   rm.P=rm.P + rm.dt*rm.V_w; %+ 1/2*rm.dt^2*rm.Acc_w;%   
  
   %% 欧拉角
   rm.Je_b=EulerJacobian(rm.Euler,'xyz','b');
   rm=rmdEuler(rm);
   rm=rmEuler(rm);
   
  %% R
   % rm=rmR(rm);
   rm=rmK(rm);
   rm.R=rm.R*rm.K;
  
end