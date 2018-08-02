%% 追加其他的力和力矩给四旋翼模型
%% 说明：所有的参数都应相对刚体坐标系
% f: 力
% r: 力臂
% t：转矩
function [ qm ] = qmAddDriver(qm, f,r,t,varargin )

   qm.rm.F=[qm.rm.F f];
   qm.rm.r=[qm.rm.r r];
   qm.rm.T=[qm.rm.T t];
   
end

