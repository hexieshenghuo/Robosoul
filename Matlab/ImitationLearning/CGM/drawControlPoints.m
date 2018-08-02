function drawControlPoints(P,varargin)
   LineStyle='-mo';%���͡���ɫ������
   MarkerFaceColor=[0 1 0];%����ɫ
   LineWidth=1;    %�߿�
   MarkerEdgeColor='g';%���Ե��ɫ
   MarkerSize=6;           %��Ĵ�С
  
   if nargin>1
       LineStyle=varargin{1};
   end
   if nargin>2
       MarkerFaceColor=varargin{2};
   end
   if nargin>3
       MarkerEdgeColor=varargin{3};
   end
   if nargin>4
       LineWidth=varargin{4};
   end
   
   if nargin>5
       MarkerSize=varargin{5};
   end

 plot(P(1,:),P(2,:),LineStyle,'LineWidth',LineWidth,...
                'MarkerEdgeColor',MarkerEdgeColor,...
                'MarkerFaceColor',MarkerFaceColor,...
                'MarkerSize',MarkerSize,...
                'MarkerFaceColor', MarkerFaceColor);

end

