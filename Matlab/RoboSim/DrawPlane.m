% P 是4×4 每列是一个[x,y,z,1]点向量
function [P] = DrawPlane(P,Color)
X=P(1,:);
Y=P(2,:);
Z=P(3,:);

fill3(X,Y,Z,Color,'EdgeColor','none');hold on;

end

