%% 第5个关节连杆的3D模型

%% 说明

%% 外部参数
global LinkLength;

l5=LinkLength(5);

l=0.012;

%% Box1
w1=0.09;
h1=0.02;
offset=[0;0;-l5 + h1/2;0];
Box1=GetBox(l,w1,h1,offset);

%% Box2
w2=0.012;
h2=0.06;
y=w1/2-w2/2;
z= h1 + h2/2 - l5;
offset=[0;y;z;0];
Box2=GetBox(l,w2,h2,offset);

%% Box3
w3=w2;
h3=h2;
y=-w1/2 + w2/2;
z= h1 + h2/2 - l5;
offset=[0;y;z;0];
Box3=GetBox(l,w3,h3,offset);

%% Box4
w4=0.012;
h4=0.012;
y= w1/2-w2-w4/2;
z= -l5 + h1 + h2 - h4/2;
offset=[0;y;z;0];
Box4=GetBox(l,w4,h4,offset);

%% Box5
w5=w4;
h5=h4;
y= -w1/2+ w2 +w4/2;
z= -l5 + h1 + h2 - h4/2;
offset=[0;y;z;0];
Box5=GetBox(l,w5,h5,offset);

%% 坐标系
Coord=GetCoord(0.12);

%% 组合
fm3d=CreateComponent();

color=[0.8 0.8 0.8];
fm3d=AddComponent(fm3d,Box1,'Box',color);

color=[0.8 0.8 0.8];
fm3d=AddComponent(fm3d,Box2,'Box',color);

color=[0.8 0.8 0.8];
fm3d=AddComponent(fm3d,Box3,'Box',color);

color=[0.9 0.1 0];
fm3d=AddComponent(fm3d,Box4,'Box',color);

color=[0.9 0.1 0];
fm3d=AddComponent(fm3d,Box5,'Box',color);


fm3d=AddComponent(fm3d,Coord,'Coord','b');
