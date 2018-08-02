%% 生成一个机械臂3D模型
%% 
% DH：D-H参数表
function [ Model ] = GetArmModel_2(DH,varargin)

[A,T]=updateTrans(DH);
[N,Col]=size(DH);
Model.DH=DH;
Model.A=A;
Model.T=T;

%% 基坐标
   if nargin>1
       P=varargin{1};
   else
       P=[0 0 0 1]';%位置
   end

Model.Base.T=Trans(P);

%% 坐标系0
Model.Coord0.T=Model.Base.T;
Model.Coord0.Component=CreateComponent();
rad0=6;
height0=7;
Cylinder0=GetCylinder(rad0,height0,60,[0 0 0 0]');
CylinderColor='r';
Model.Coord0.Component=AddComponent(Model.Coord0.Component,Cylinder0,'Cylinder',CylinderColor);
Model.Coord0.Component=TransComponent(Model.Coord0.T,Model.Coord0.Component);

%% 坐标系1
Model.Coord{1}.Component=CreateComponent();
cyrad1=6;
cyheight1=7;
Cylinder1=GetCylinder(cyrad1,cyheight1,60,[0 0 0 0]');
CylinderColor1='r';
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,Cylinder1,'Cylinder',CylinderColor1);
% box
boxlen1=-DH(1,3);
boxwid1=6;
boxheight1=6;
boxoffset1=[boxlen1/2 0 0 0]';
Box1=GetBox(boxlen1,boxwid1,boxheight1,boxoffset1);
BoxColor1='b';
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,Box1,'Box',BoxColor1);

%CoordAxis1
CoordAixs1=GetCoord(30);
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,CoordAixs1,'Coord','r');

%% 坐标系2
Model.Coord{2}.Component=CreateComponent();
cyrad2=6;
cyheight2=7;
Cylinder2=GetCylinder(cyrad2,cyheight2,60,[0 0 0 0]');
CylinderColor2='r';
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,Cylinder2,'Cylinder',CylinderColor2);

% box
boxlen2=-DH(2,3);
boxwid2=6;
boxheight2=6;
boxoffset2=[boxlen2/2 0 0 0]';
Box2=GetBox(boxlen2,boxwid2,boxheight2,boxoffset2);
BoxColor2='g';
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,Box2,'Box',BoxColor2);

CoordAixs2=GetCoord(30);
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,CoordAixs2,'Coord','r');

%% 坐标系3
Model.Coord{3}.Component=CreateComponent();
cyrad3=6;
cyheight3=7;
Cylinder3=GetCylinder(cyrad3,cyheight3,60,[0 0 0 0]');
CylinderColor3='r';
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,Cylinder3,'Cylinder',CylinderColor3);

% box
boxlen3=-DH(3,3);
boxwid3=6;
boxheight3=6;
boxoffset3=[boxlen3/2 0 0 0]';
Box3=GetBox(boxlen3,boxwid3,boxheight3,boxoffset3);
BoxColor3='g';
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,Box3,'Box',BoxColor3);

CoordAixs3=GetCoord(60);
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,CoordAixs3,'Coord','r');

%% 坐标系4
Model.Coord{4}.Component=CreateComponent();
cyrad4=6;
cyheight4=7;
Cylinder4=GetCylinder(cyrad4,cyheight4,60,[0 0 0 0]');
CylinderColor4='r';
Model.Coord{4}.Component=AddComponent(Model.Coord{4}.Component,Cylinder4,'Cylinder',CylinderColor4);

% box
boxlen4=-DH(4,3);
boxwid4=6;
boxheight4=6;
boxoffset4=[boxlen4/2 0 0 0]';
Box4=GetBox(boxlen4,boxwid4,boxheight4,boxoffset4);
BoxColor4='g';
Model.Coord{4}.Component=AddComponent(Model.Coord{4}.Component,Box4,'Box',BoxColor4);

CoordAixs4=GetCoord(60);
Model.Coord{4}.Component=AddComponent(Model.Coord{4}.Component,CoordAixs4,'Coord','r');

%% 坐标系5
Model.Coord{5}.Component=CreateComponent();
cyrad5=6;
cyheight5=7;
Cylinder5=GetCylinder(cyrad5,cyheight5,60,[0 0 0 0]');
CylinderColor5='r';
Model.Coord{5}.Component=AddComponent(Model.Coord{5}.Component,Cylinder5,'Cylinder',CylinderColor5);

% box
boxlen5=-DH(5,3);
boxwid5=6;
boxheight5=6;
boxoffset5=[boxlen5/2 0 0 0]';
Box5=GetBox(boxlen5,boxwid5,boxheight5,boxoffset5);
BoxColor5='g';
Model.Coord{5}.Component=AddComponent(Model.Coord{5}.Component,Box5,'Box',BoxColor5);

CoordAixs5=GetCoord(60);
Model.Coord{5}.Component=AddComponent(Model.Coord{5}.Component,CoordAixs5,'Coord','r');

%% 坐标系6
Model.Coord{6}.Component=CreateComponent();
cyrad6=6;
cyheight6=7;
Cylinder6=GetCylinder(cyrad6,cyheight6,60,[0 0 0 0]');
CylinderColor6='r';
Model.Coord{6}.Component=AddComponent(Model.Coord{6}.Component,Cylinder6,'Cylinder',CylinderColor6);

% box
boxlen6=-DH(6,3);
boxwid6=6;
boxheight6=6;
boxoffset6=[boxlen6/2 0 0 0]';
Box6=GetBox(boxlen6,boxwid6,boxheight6,boxoffset6);
BoxColor6='g';
Model.Coord{6}.Component=AddComponent(Model.Coord{6}.Component,Box6,'Box',BoxColor6);

CoordAixs6=GetCoord(60);
Model.Coord{6}.Component=AddComponent(Model.Coord{6}.Component,CoordAixs6,'Coord','r');

%% Show
   Model.ShowComponent=Model.Coord0.Component;
   Model.ShowComponent=JointComponents(Model.ShowComponent,Model.Coord0.Component);
   for i=1:N
        Model.Coord{i}.Component=TransComponent(Model.Coord0.T*Model.T{i},Model.Coord{i}.Component);
        Model.ShowComponent=JointComponents(Model.ShowComponent,Model.Coord{i}.Component);
   end
end