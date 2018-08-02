% Draw a Line
% you can pirnt "DrawLine(P)" on Command window like this:
% >>P=[[1 2 3 1]' [4 5 6 1]'];
% >>DrawLin(P);
function DrawLine(P,width,color)

x=P(1,:);
y=P(2,:);
z=P(3,:);
plot3(x,y,z,'linewidth',width,'color',color);hold on;
end
