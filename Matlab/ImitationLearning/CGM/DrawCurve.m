%% 画一条曲线
function DrawCurve(Curve,varargin)
   [Dim,M]=size(Curve);
  
   LineStyle='-mo';%线型、颜色、点型
   MarkerFaceColor=[1 0 0];%点颜色
   LineWidth=1;    %线宽
   MarkerEdgeColor='r';%点边缘颜色
   MarkerSize=1;           %点的大小
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

