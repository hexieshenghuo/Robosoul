function [GradientI]=getImageGradient(I,method,option)
radius=1;
switch method
    case 'r'%'roberts'
        TempX=[1 0;0 -1];
        TempY=[0 1;-1 0];
        GradientI.Px=imfilter(I,TempX);
        GradientI.Py=imfilter(I,TempY);
        radius=1;
    case 'p'%'prewitt'
        TempX=[-1 0 1;-1 0 1;-1 0 1];
        TempY=[1 1 1;0 0 0;-1 -1 -1];
        GradientI.Px=imfilter(I,TempX);
        GradientI.Py=imfilter(I,TempY);
        radius=2;
    case 's'%'sobel'
        TempX=[-1 0 1;-2 0 2;-1 0 1];
        TempY=[1 2 1;0 0 0;-1 -2 -1];
        GradientI.Px=imfilter(I,TempX);
        GradientI.Py=imfilter(I,TempY);
        radius=2;
end
sizeI=size(I);

GradientI.Angle=zeros(sizeI(1),sizeI(2));
GradientI.Mag=zeros(sizeI(1),sizeI(2));

GradientI.Px=double(GradientI.Px);
GradientI.Py=double(GradientI.Py);

if option.IsFloat
    GradientI.Px=GradientI.Px/255;
    GradientI.Py=GradientI.Py/255;
end

for x=1+radius:sizeI(2)-radius
    for y=1+radius:sizeI(1)-radius
        GradientI.Mag(y,x)=sqrt( GradientI.Px(y,x)^2+GradientI.Py(y,x)^2 );
        GradientI.Angle(y,x)=atan2(GradientI.Py(y,x),GradientI.Px(y,x));
        if GradientI.Angle(y,x)<0
            GradientI.Angle(y,x)=GradientI.Angle(y,x)+2*pi;
        end
    end
end
end