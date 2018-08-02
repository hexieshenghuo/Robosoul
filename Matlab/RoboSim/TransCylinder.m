function [ Cylinder] = TransCylinder(Trans,Cylinder)

Cylinder.Cylinder=Trans*Cylinder.Cylinder;
Cylinder.Top=Trans*Cylinder.Top;
Cylinder.Bottom=Trans*Cylinder.Bottom;

end