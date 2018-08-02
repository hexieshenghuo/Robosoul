function [ Component] = DrawComponent( Component )
s=size(Component.Part);
n=s(2);

for i=1:n
    switch Component.Type{i}
        case 'Cylinder'
            DrawCylinder(Component.Part{i},Component.Color{i});
        case 'cylinder'
            DrawCylinder(Component.Part{i},Component.Color{i});
        case 'Box'
            DrawBox(Component.Part{i},Component.Color{i});
        case 'box'
            DrawBox(Component.Part{i},Component.Color{i});
        case 'Coord'
            DrawCoord(Component.Part{i},1);
        case 'coord'
            DrawCoord(Component.Part{i},1);
        case 'HalfCylinder'
            DrawHalfCylinder(Component.Part{i},Component.Color{i});
        case 'halfCylinder'
            DrawHalfCylinder(Component.Part{i},Component.Color{i});
        case 'Disc'
            DrawDisc(Component.Part{i},Component.Color{i});
        case 'disc'
            DrawDisc(Component.Part{i},Component.Color{i});    
        case 'Plane'
            DrawPlane(Component.Part{i},Component.Color{i});
        case 'plane'
            DrawPlane(Component.Part{i},Component.Color{i});
        case 'Line'
            DrawLine(Component.Part{i},3,Component.Color{i});
        case 'line'
            DrawLine(Component.Part{i},3,Component.Color{i});
    end
end

end

