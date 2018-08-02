%% 计算坐标系间速度的变换矩阵BJA
%% 参考：《Robotics Toolbox Manual》 3.1 Forward and inverse kinematics，
%% 特别是公式（10）
%% 
% ATB：坐标系B到A系的变换矩阵
function [ J ] = BJA( ATB )
  
   T=ATB;   
   n=Vn(T);
   o=Vo(T);
   a=Va(T);
   p=Vp(T);
   
   R=MR(T)';
   
   p_n=cross(p,n);
   p_o=cross(p,o);
   p_a=cross(p,a);
   
   B=[p_n p_o p_a].';
   
   J=[R B;zeros(3) R];
end

