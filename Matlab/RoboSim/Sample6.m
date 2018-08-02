P = GetCylinder(3,8,1000,[0 0 0 0]');% 生成一个中心在原点的圆柱的点
C= GetCoord(18);%画一个坐标系

P=TransCylinder(Rot(pi/3,'y'),P);%变换,绕Xpi/3
C=TransCoord(Rot(pi/3,'y'),C);%变换,绕Xpi/3
DrawCoord(C,1);
DrawCylinder(P,'r');
SetShowState(20);