%% 找曲线Y各个点弧长约束对应BSpline曲线的参数点
%% 说明
% Ytm: 每个Yi点对应的BSpline参数编号
% SC :B-Spline曲线
% varargin{1}: dt
function [Ytm] = findArcRatiotm(Y,Points,k,varargin)
%------初始化   
   [Dim,N]=size(Points);
   T=getT(N,k);
   dt=0.001;
   if nargin>3 %外部赋值
       dt=varargin{1};
   end
%------生成BSpline曲线
   [SC,t]=createBSplineCurve(Points,k,dt); %

%------计算弧长
   [YArcLength,YArcRatio]=getArcLength(Y);
   [SCArcLength,SCArcRatio]=getArcLength(SC);

%------查找对应弧长tm
   M=length(Y);  %Y点数
   %thres=1/M*0.005;% 接受比例阈值
   Ytm=zeros(1,M);% tm为行向量
   
   i=2;          %Spline曲线序号
   n=length(t);%个数
   for m=2:M
       for j=i:n
           if YArcRatio(m)>=SCArcRatio(j-1) & YArcRatio(m)<=SCArcRatio(j)
               Ytm(m)=t(j - ( YArcRatio(m)-SCArcRatio(j-1) < SCArcRatio(j) - YArcRatio(m)) );
               i=max(2,j-1);% 为了处理速度为0的轨迹段 +1
%                i=max(2,j - ( YArcRatio(m)-SCArcRatio(j-1) < SCArcRatio(j) - YArcRatio(m)) )+1;
               break;
           end
       end
   end
end