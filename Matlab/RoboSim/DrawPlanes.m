%画多个平面 P每四列为一个平面坐标
function [P] = DrawPlanes(P,Num,Colors)

for i=0:Num-1
    p=P(:,i*4+1:i*4+4);
    DrawPlane(p,Colors);
end
end

