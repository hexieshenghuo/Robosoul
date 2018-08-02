function [Part] = DrawCoord(Part,Width)

DrawLine(Part.P(:,1:2),Width,'b');% X
DrawLine(Part.P(:,3:4),Width,'g');% Y
DrawLine(Part.P(:,5:6),Width,'r');% Z

end