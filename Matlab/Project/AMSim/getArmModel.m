%% 生成一个机械臂3D模型
%%
% DH: D-H参数表
% ArmT：Arm的T矩阵集合
% BaseT：机械臂的基座系在全局坐标系的变换矩阵
function [Component] = getArmModel(ArmT,BaseT,DH,varargin)

%% 固定参数
MotorRad=20;
MotorHeight=27;
BoxHeight=20;
BoxWid=20;
BoxLength=20;

global ArmTrans;
BaseBoxL=20;
BaseBoxW=ArmTrans;
BaseBoxH=20;

%% 基坐标
T=ArmT;
%% 坐标系0
Model.Coord0.T=BaseT;
Model.Coord0.Component=CreateComponent();
rad0=MotorRad;
height0=MotorHeight;

Cylinder0=GetCylinder(rad0,height0,60,[0 0 0 0]');
CylinderColor='r';

BaseBoxOffset=[0 BaseBoxW/2 0 0]';
BaseBox=GetBox(BaseBoxL,BaseBoxW,BaseBoxH,BaseBoxOffset);
BaseBoxColor= 'g';

Model.Coord0.Component=AddComponent(Model.Coord0.Component,BaseBox,'Box',BaseBoxColor);
Model.Coord0.Component=AddComponent(Model.Coord0.Component,Cylinder0,'Cylinder',CylinderColor);

Model.Coord0.Component=TransComponent(Model.Coord0.T,Model.Coord0.Component);


%% 坐标系1
Model.Coord{1}.Component=CreateComponent();
cyrad1=MotorRad;
cyheight1=MotorHeight;
Cylinder1=GetCylinder(cyrad1,cyheight1,60,[0 0 0 0]');
CylinderColor1='r';
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,Cylinder1,'Cylinder',CylinderColor1);
% box
boxlen1=-DH(1,3);
boxwid1=BoxWid;
boxheight1=BoxHeight;
boxoffset1=[boxlen1/2 0 0 0]';
Box1=GetBox(boxlen1,boxwid1,boxheight1,boxoffset1);
BoxColor1='b';
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,Box1,'Box',BoxColor1);

%CoordAxis1
CoordAixs1=GetCoord(30);
Model.Coord{1}.Component=AddComponent(Model.Coord{1}.Component,CoordAixs1,'Coord','r');

%% 坐标系2
Model.Coord{2}.Component=CreateComponent();
cyrad2=MotorRad;
cyheight2=MotorHeight;
Cylinder2=GetCylinder(cyrad2,cyheight2,60,[0 0 0 0]');
CylinderColor2='r';
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,Cylinder2,'Cylinder',CylinderColor2);

% box
boxlen2=-DH(2,3);
boxwid2=BoxWid;
boxheight2=BoxHeight;
boxoffset2=[boxlen2/2 0 0 0]';
Box2=GetBox(boxlen2,boxwid2,boxheight2,boxoffset2);
BoxColor2='g';
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,Box2,'Box',BoxColor2);

CoordAixs2=GetCoord(30);
Model.Coord{2}.Component=AddComponent(Model.Coord{2}.Component,CoordAixs2,'Coord','r');

%% 坐标系3
Model.Coord{3}.Component=CreateComponent();
cyrad3=MotorRad;
cyheight3=MotorHeight;
cyoffset3=[0 0 DH(4,2)-cyheight3/2 0]';
Cylinder3=GetCylinder(cyrad3,cyheight3,60,cyoffset3);
CylinderColor3='r';
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,Cylinder3,'Cylinder',CylinderColor3);
% box
boxlen3=BoxLength;
boxwid3=BoxWid;
boxheight3=DH(4,2);
boxoffset3=[0 0 boxheight3/2 0]';
Box3=GetBox(boxlen3,boxwid3,boxheight3,boxoffset3);
BoxColor3='g';
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,Box3,'Box',BoxColor3);

%Coord
CoordAixs3=GetCoord(120);
Model.Coord{3}.Component=AddComponent(Model.Coord{3}.Component,CoordAixs3,'Coord','r');

%% 坐标系4

%% Show
   Model.ShowComponent=Model.Coord0.Component;
   Model.ShowComponent=JointComponents(Model.ShowComponent,Model.Coord0.Component);
   for i=1:3
        Model.Coord{i}.Component=TransComponent(Model.Coord0.T*T{i},Model.Coord{i}.Component);
        Model.ShowComponent=JointComponents(Model.ShowComponent,Model.Coord{i}.Component);
   end
   Component=Model.ShowComponent;
end
