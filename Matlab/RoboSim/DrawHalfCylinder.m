function [P] = DrawHalfCylinder(P,Color)

%解码!
%圆柱
cylinderX=P.Cylinder(1,:);
cylinderY=P.Cylinder(2,:);
cylinderZ=P.Cylinder(3,:);

cylinderX=reshape(cylinderX,2,length(cylinderX)/2);
cylinderY=reshape(cylinderY,2,length(cylinderY)/2);
cylinderZ=reshape(cylinderZ,2,length(cylinderZ)/2);

%上

topX=P.Top(1,:);
topY=P.Top(2,:);
topZ=P.Top(3,:);

%下
bottomX=P.Bottom(1,:);
bottomY=P.Bottom(2,:);
bottomZ=P.Bottom(3,:);

%矩形
rectX=P.Rect(1,:);
rectY=P.Rect(2,:);
rectZ=P.Rect(3,:);

%绘制
surf(cylinderX,cylinderY,cylinderZ,'FaceColor',Color,'EdgeColor','none');hold on;

fill3(topX,topY,topZ,Color,'EdgeColor','none');hold on;

fill3(bottomX,bottomY,bottomZ,Color,'EdgeColor','none');hold on;

fill3(rectX,rectY,rectZ,Color,'EdgeColor','none');hold on;
end