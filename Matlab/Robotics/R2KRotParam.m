%% 由旋转矩阵R计算等价的旋量参数w与θ
%% 参考《机器人学的数学导论》 P18 （2.17）（2.18）式
% R：3×3旋转矩阵
% w:转轴向量
% theta: 转角（θ）

function [ w, theta] = R2KRotParam( R )
   
   theta=acos( (trace(R)-1)/2 );
   
   theta=min(pi*2-theta,theta);
   w=[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)]/(2*sin(theta));
 
end