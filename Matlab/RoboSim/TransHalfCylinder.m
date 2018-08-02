function [ HalfCylinder ] = TransHalfCylinder( Trans,HalfCylinder )

   HalfCylinder.Cylinder=Trans*Cylinder.Cylinder;
   HalfCylinder.Top=Trans*Cylinder.Top;
   HalfCylinder.Bottom=Trans*Cylinder.Bottom;
   HalfCylinder.Rect=Trans*Cylinder.Rect;

end

