%% 利用外部输入单纯更新刚体模型位姿
% rm:刚体模型
% P：坐标系原点相对世界坐标系的位置
% Pose:姿态参数 如果是3×1向量 为欧拉角，如果是3×3的那么就是旋转矩阵
function [ rm ] = rmUpdatePose(rm,P,Pose)

   rm.P=P;
   s=size(Pose);
   if s(2)==1 % 3×1 认为是欧拉角
       rm.Euler=Pose;
       rm.R=EulerRotMat(Pose);
   else       % 3×3 认为是R
       rm.R=Pose;
   end
end