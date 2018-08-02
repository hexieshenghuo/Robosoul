%% 利用转速更新由旋翼生成的对四旋翼的力和力矩
%% 说明 
% 实质是更新qm里的rm(刚体模型)结构
% w：n×1 电机转速向量，n为电机的个数
% qm: 四旋翼模型

function [ qm ] = qmUpdateDriver( qm , w , varargin )
  
   %% 力
   % 推进力
   
   f=qm.Ktf*w;
   
   f=f.'; % 1×n
   % x y z 逐个乘
   F1=qm.Fn(1,:).*f; % 1×n
   F2=qm.Fn(2,:).*f; % 1×n
   F3=qm.Fn(3,:).*f; % 1×n
   
   F=[F1;F2;F3];% 3×n
   
   % 重力
   qm.Gb=qm.rm.R.'*qm.G;% Body坐标系下的重力
   
   % 全部力加入rm
   qm.rm.F=[F qm.Gb];
   
   %% 力矩
   t=qm.Kct*w;
   t=t.';
   T1=qm.Tn(1,:).*t;
   T2=qm.Tn(2,:).*t;
   T3=qm.Tn(3,:).*t;
   
   T=[T1;T2;T3];
   
   qm.rm.T=T;
   
end