% P ��4��4 ÿ����һ��[x,y,z,1]������
function [P] = DrawPlane(P,Color)
X=P(1,:);
Y=P(2,:);
Z=P(3,:);

fill3(X,Y,Z,Color,'EdgeColor','none');hold on;

end

