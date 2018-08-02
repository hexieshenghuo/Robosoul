%% ��һ������
function DrawCurve(Curve,varargin)
   [Dim,M]=size(Curve);
  
   LineStyle='-mo';%���͡���ɫ������
   MarkerFaceColor=[1 0 0];%����ɫ
   LineWidth=1;    %�߿�
   MarkerEdgeColor='r';%���Ե��ɫ
   MarkerSize=1;           %��Ĵ�С
   if nargin>1 % LineStyle
       LineStyle=varargin{1};
   end
   if nargin>2 % LineWidth
       LineWidth=varargin{2};
   end
   if nargin>3 % MarkEdgeColor
       MarkerEdgeColor=varargin{3};
   end
   
   if nargin>4 % MarkFaceColor
       MarkerFaceColor=varargin{4};
   end
 
   if nargin>5 % MarkSize
       MarkerSize=varargin{5};
   end
  
   X=Curve(1,:);
   Y=Curve(2,:);
   if Dim==2
       plot(X,Y,LineStyle,'LineWidth',LineWidth,'MarkerEdgeColor',MarkerEdgeColor,...
       'MarkerFaceColor',MarkerFaceColor,'MarkerSize',MarkerSize);
   end
   
   if Dim==3
       Z=Curve(3,:);
       plot3(X,Y,Z,LineStyle,'LineWidth',LineWidth,'MarkerEdgeColor',MarkerEdgeColor,...
       'MarkerFaceColor',MarkerFaceColor,'MarkerSize',MarkerSize);
   end
end

