%得到半圆柱矩阵
function [P] = GetHalfCylinder(R,Height,N,Offset)

%圆柱筒
[x,y,z]=cylinder(R,N*2);
z=z*Height;
z=z-Height/2;

lx=int16(length(x)/2);
ly=int16(length(y)/2);
lz=int16(length(z)/2);
x=x(:,1:lx);
y=y(:,1:ly);
z=z(:,1:lz);

%矩形
RectX=[x(1,1) x(2,1) x(2,lx) x(1,lx)];
RectY=[y(1,1) y(2,1) y(2,ly) y(1,ly)];
RectZ=[z(1,1) z(2,1) z(2,lz) z(1,lz)];

x=reshape(x,1,length(x)*2);
y=reshape(y,1,length(y)*2);
z=reshape(z,1,length(z)*2);

%半圆面
theta=0:pi/N:pi;
%上圆
topX=cos(theta)*R;
topY=sin(theta)*R;
topZ=ones(1,length(topX))*Height/2;

%下圆
bottomX=cos(theta)*R;
bottomY=sin(theta)*R;
bottomZ=ones(1,length(topX))*Height/-2;

%转型
%cylinder
P.Cylinder=[x;y;z;ones(1,length(x))];

offset=repmat(Offset,1,length(P.Cylinder));
P.Cylinder=P.Cylinder+offset;

%Rect
P.Rect=[RectX;RectY;RectZ;ones(1,4)];
offset=repmat(Offset,1,4);
P.Rect=P.Rect+offset;

%Bottom
P.Bottom=[bottomX;bottomY;bottomZ;ones(1,length(bottomX))];
offset=repmat(Offset,1,length(P.Bottom));
P.Bottom=P.Bottom+offset;

%Top
P.Top=[topX;topY;topZ;ones(1,length(topX))];
offset=repmat(Offset,1,length(P.Top));
P.Top=P.Top+offset;
end

