%% 第1个关节连杆的3D模型

%% 说明

%% 外部参数
global LinkLength;

%% 电机
R=0.018;
Height=0.06;

Motor = GetCylinder(R,Height,36);

%% 连杆
offset=[LinkLength(1)/2;0;0;0];
length=LinkLength(1);
width=0.03;
height=0.03;
Link=GetBox(length,width,height,offset);

%% 坐标系
Coord=GetCoord(0.12);

%% 组合
fm3d=CreateComponent();

color=[0.5 0.2 0.1];
fm3d=AddComponent(fm3d,Motor,'Cylinder',color);

color=[0.36 0.36 0.36];
fm3d=AddComponent(fm3d,Link,'Box',color);

fm3d=AddComponent(fm3d,Coord,'Coord','b');