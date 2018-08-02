%% 位姿计算测试
%% 初始化
BaseCoord=GetCoord(16);
MatBase=eye(4);

Offset=[0 0 0 0]';
Box=GetBox(3,6,9,Offset);
Box1=GetBox(3,6,9,Offset);
Box2=GetBox(3,6,9,Offset);

angle_1=pi/6;
RotMat_1=Rot(angle_1,'x');

Coord_1=GetCoord(16);
Coord_2=GetCoord(16);
RightM=RotMat_1;
for i=1:100
    clf;
    DMat=Rot(pi/180*0.5,'z');
    RightM=RightM*DMat;
    Coord_2=TransCoord(RightM,BaseCoord);
    Box2=TransBox(RightM,Box);
    DrawCoord(BaseCoord,1);
    DrawCoord(Coord_2,1);

    DrawBox(Box2,[0.9 0.3 0.3]);
    grid on;
    axis equal;
    SetShowState(20);
    drawnow;
    pause(0.05);
end
%%



