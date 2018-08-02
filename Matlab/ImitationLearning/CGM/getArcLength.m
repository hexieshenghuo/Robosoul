%% 计算曲线各个点相对起点弧长和占整个弧的比例
%% 说明
% ArcLength： 各个点到起点的弧长 N×1
% ArcRatio：  各点的弧长比例    N×1
% N： 点个数
function [ArcLength,ArcRatio] = getArcLength(Curve)
   [Dim,N]=size(Curve);% Dim 点维数 N 点个数
   SectionLength=zeros(N,1);
   ArcLength=zeros(N,1);
   ArcRatio=zeros(N,1);
   SectionLength(1)=0; % 单段弧长
   ArcLength(1)=0;
   ArcRatio(1)=0;
   
   for i=2:N
       SectionLength(i)=norm(Curve(:,i)-Curve(:,i-1));
       ArcLength(i)=sum(SectionLength(1:i)); %
   end
   
   ArcRatio=ArcLength/ArcLength(N);
   
end