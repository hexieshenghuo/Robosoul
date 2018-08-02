function [ Component] = DrawComponent( Component )

n=length(Component);

for i=1:n
    switch Component(i).Type
        case 'Cylinder'
            DrawCylinder(Component(i).Part,Component(i).Color);
        case 'cylinder'
            DrawCylinder(Component(i).Part,Component(i).Color);
        case 'Box'
            DrawBox(Component(i).Part,Component(i).Color);
        case 'box'
            DrawBox(Component(i).Part,Component(i).Color);
        case 'Coord'
            DrawCoord(Component(i).Part,0.6);
        case 'coord'
            DrawCoord(Component(i).Part,0.6);
        case 'HalfCylinder'
            DrawHalfCylinder(Component(i).Part,Component(i).Color);
        case 'halfcylinder'
            DrawHalfCylinder(Component(i).Part,Component(i).Color);
        case 'Disc'
            DrawDisc(Component(i).Part.P,Component(i).Color);
        case 'disc'
            DrawDisc(Component(i).Part.P,Component(i).Color);
        case 'Plane'
            DrawPlane(Component(i).Part.P,Component(i).Color);
        case 'plane'
            DrawPlane(Component(i).Part.P,Component(i).Color);
        case 'Line'
            DrawLine(Component(i).Part.P,3,Component(i).Color);
        case 'line'
            DrawLine(Component(i).Part.P,3,Component(i).Color);
    end
end

end

