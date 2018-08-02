%% 根据给定控制点实时生成曲线点与速度
%% 说明
% ControlPoints:   当前控制点 包括位置与速度两类
% VelControlPoints:速度控制点
% CurrentCurvePoint：当前的轨迹点
% t:  当前t参数
% dt: 参数分割
% CurveParam：轨迹参数
%%
function [CurvePoint,Velocity] = regenerateCurve( ControlPoints,CurrentCurvePoint,t,CurveParam,varargin)
   PosControlPoints=ControlPoints.PosControlPoints;
   k=CurveParam.k;
   T=CurveParam.T;
   dt=CurveParam.dt;
   Step=CurveParam.Step;
   LocalRange=0.3;
end