%% 根据参数计算B-Spline曲线某一点
%% 说明 
% t:BSpline的轴参数
% P：控制点
% T：分割参数
% k：阶数
% N: P的列数 即控制点数
function [ CurvePoint ] = getBSplinePoint(t,P,T,k,N,Dim)
   CurvePoint=zeros(Dim,1);
   for i=1:N
       CurvePoint=CurvePoint+P(:,i).*B(t,i,k,T);
   end
end

