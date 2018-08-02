%% 计算速度变换的伴随变换(adjoint transformation)
%% 《机器人操作的数学导论》P34 （2.57） 和 (2.58)
%% 
function [ M ] = Adg( R,p )
   M=[R Sw(p)*R;zeros(3) R];
end