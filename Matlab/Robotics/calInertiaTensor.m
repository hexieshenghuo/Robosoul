%% 计算刚体相对自身坐标系（坐标原点位于质心）的惯性张量矩阵
%% 说明 假设材质均匀
% I： 3×3惯性张量矩阵
% Type: 刚体的几何类型
% 'b' -cuboid    长方体
% 's' -sphere    球体
% 'c' -cylinder  圆柱体
% '+' -cross     十字架结构,即四旋翼主体结构
% Param：n×1 向量，根据Type不同形式不同
% Pc: varargin{1}, 3×1列向量，计算任意坐标系｛A｝的I时需要的参数，P是刚体质心在｛A｝的位置
% Ia与Ic的关系参考《机器人学导论》P135 (6-26)式

function [ I ,varargout] = calInertiaTensor( Type, Param,varargin)
   Pc=[0;0;0];
  
   if nargin>2 % 设置Pc
       Pc=varargin{1};
   end
   
   Ic=eye(3);
   
   switch Type
       case 'b' % 长方体
           l=Param(1);% 长 x
           w=Param(2);% 宽 y
           h=Param(3);% 高 z
           m=Param(4); % 质量
           Ic=diag([h^2+w^2; h^2+l^2 ; l^2+ w^2 ])*m/12;
       case '+' % 十字架
           l=Param(1);% 长 x
           w=Param(2);% 宽 y
           h=Param(3);% 高 z
           m=Param(4); % 质量
           s=min(l,w);
           % 计算m
           ms=s/max(l,w)*m;
           Ic1=diag([h^2+w^2; h^2+l^2 ; l^2+ w^2 ])*m/12;
           Ic2=diag([h^2+l^2; h^2+w^2 ; l^2+ w^2 ])*m/12;
           Ic3=diag([h^2+s^2; h^2+s^2 ; s^2+ s^2 ])*ms/12;
           Ic=Ic1+Ic2-Ic3;
       case 'c' % 圆柱体
       case 's' % 球体
   end
   
   I=Ic + m*(Pc.'*Pc*eye(3)-Pc*Pc.'); %《机器人学导论》 P135 （6-26）式
   
   if nargout>1 %输出Ic
       varargout{1}=Ic;
   end
end