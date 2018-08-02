%% GUI方式得到2维控制点
% N：       控制点数
% Range：   控制点取值范围
% P:        获取的控制点 Dim×N  Dim：维数 N：点数
%%
function[P,N] =getControlPoints(N,Range)
   close all;
   figure(1);
   hold on; box on;
   set(gca,'Fontsize',16);
   if length(Range)==1
       axis([-1*Range Range -1*Range Range]);
   else
       axis(Range);
   end
   for i = 1:N
       P(i,:) = ginput(1);
       drawControlPoints(P');
%     plot(P(:,1),P(:,2),'--ro','LineWidth',1,...
%                 'MarkerEdgeColor','g',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',6,'MarkerFaceColor','g');
   end
   P=P';
end