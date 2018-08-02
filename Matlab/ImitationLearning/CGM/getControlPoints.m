%% GUI��ʽ�õ�2ά���Ƶ�
% N��       ���Ƶ���
% Range��   ���Ƶ�ȡֵ��Χ
% P:        ��ȡ�Ŀ��Ƶ� Dim��N  Dim��ά�� N������
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