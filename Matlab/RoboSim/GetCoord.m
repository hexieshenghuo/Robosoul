% PΪ4��3���� �������ֱ�Ϊ X Y Z! 
function [Part] = GetCoord(scale)
X=[[0 0 0 1]' [scale 0 0 1]'];
Y=[[0 0 0 1]' [0 scale 0 1]'];
Z=[[0 0 0 1]' [0 0 scale 1]'];

P=[X Y Z];
Part.P=P;
end

