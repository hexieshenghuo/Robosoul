%% ���ݸ������Ƶ�ʵʱ�������ߵ����ٶ�
%% ˵��
% ControlPoints:   ��ǰ���Ƶ� ����λ�����ٶ�����
% VelControlPoints:�ٶȿ��Ƶ�
% CurrentCurvePoint����ǰ�Ĺ켣��
% t:  ��ǰt����
% dt: �����ָ�
% CurveParam���켣����
%%
function [CurvePoint,Velocity] = regenerateCurve( ControlPoints,CurrentCurvePoint,t,CurveParam,varargin)
   PosControlPoints=ControlPoints.PosControlPoints;
   k=CurveParam.k;
   T=CurveParam.T;
   dt=CurveParam.dt;
   Step=CurveParam.Step;
   LocalRange=0.3;
end