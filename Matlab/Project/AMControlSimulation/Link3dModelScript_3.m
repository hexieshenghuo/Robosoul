%% ��3���ؽ����˵�3Dģ��

%% ˵��

%% �ⲿ����
global LinkLength;

%% ���
R=0.018;
Height=0.06;

Motor = GetCylinder(R,Height,36);

%% ����
offset=[0;LinkLength(3)/2;0;0];
length=0.03;        % X
width=LinkLength(3);% Y
height=0.03;        % Z
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