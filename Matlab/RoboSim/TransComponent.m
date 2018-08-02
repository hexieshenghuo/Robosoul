%% 用变换矩阵变换一个Component!
function [ Component ] = TransComponent(Trans,Component )

n=length(Component);

for i=1:n
    switch Component(i).Type
        case 'Cylinder'
            Component(i).Part=TransCylinder(Trans,Component(i).Part);
        case 'cylinder'
            Component(i).Part=TransCylinder(Trans,Component(i).Part);
        case 'Box'
            Component(i).Part.P=Trans*Component(i).Part.P;
        case 'box'
            Component(i).Part.P=Trans*Component(i).Part.P;
        case 'HalfCylinder'
            Component(i).Part=TransHalfCylinder(Trans,Component(i).Part);
        case 'halfCylinder'
             Component(i).Part=TransHalfCylinder(Trans,Component(i).Part);
        otherwise
            Component(i).Part.P=Trans*Component(i).Part.P;
    end
    Component(i).Type=Component(i).Type;
    Component(i).Color=Component(i).Color;
    Component(i).Use=Component(i).Use;
end
end

