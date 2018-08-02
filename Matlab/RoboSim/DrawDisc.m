function [P] = DrawDisc(P,Color)

x=P(1,:);
y=P(2,:);
z=P(3,:);

fill3(x,y,z,Color,'EdgeColor','none');hold on;

end

