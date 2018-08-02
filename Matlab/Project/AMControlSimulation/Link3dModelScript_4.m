%% ��4���ؽ����˵�3Dģ��

%% ˵��

%% �ⲿ����
global LinkLength;

%% ���
R=0.030;
Height=0.03;

Motor = GetCylinder(R,Height,36);

%% ����
offset=[0;0;LinkLength(4)/2;0];
length=0.03;           % X
width=0.03;            % Y
height=LinkLength(4);  % Z
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