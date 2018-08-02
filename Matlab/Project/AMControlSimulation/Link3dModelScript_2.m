%% ��2���ؽ����˵�3Dģ��

%% ˵��

%% �ⲿ����
global LinkLength;

%% ���
R=0.018;
Height=0.06;

Motor = GetCylinder(R,Height,36);

%% ����
offset=[LinkLength(2)/2;0;0;0];
length=LinkLength(2);
width=0.03;
height=0.03;
Link=GetBox(length,width,height,offset);

%% ����ϵ
Coord=GetCoord(0.12);

%% ���
fm3d=CreateComponent();

color=[0.5 0.2 0.1];
fm3d=AddComponent(fm3d,Motor,'Cylinder',color);

color=[0.36 0.36 0.36];
fm3d=AddComponent(fm3d,Link,'Box',color);

fm3d=AddComponent(fm3d,Coord,'Coord','b');