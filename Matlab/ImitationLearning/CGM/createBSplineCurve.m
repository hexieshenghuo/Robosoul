%% 生成B-Spline曲线
% P:控制点 Dim×N  Dim：维数 N：点数
% k:阶数
% dt:间隔
% Curve:Dim×Num, Num:曲线点数 Dim：曲线维数
% t: 参数序列 
function [Curve,t] = createBSplineCurve(P,k,dt,varargin)
   [Dim,N]=size(P); % Dim: 曲线的维数
   T=getT(N,k);
   if nargin>3
       t=varargin{1};
   else
       t=gent(T,dt);
   end 
   Curve=zeros(Dim,length(t)); 
   % ------以下用向量方式
   for j=1:Dim
       for i=1:N
           Curve(j,:)=Curve(j,:)+P(j,i).*B(t,i,k,T);% 该行代码为向量操作，Curve(j,:)为向量
       end
   end
    % ------以下为逐点计算形式
%  for j=1:length(t)
%      Curve(:,j)=getBSplinePoint(t(j),P,T,k,N,Dim);
%  end

end

