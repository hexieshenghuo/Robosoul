%% �õ�������3Dģ��
function [ MultiRotor] = getAerialModel(varargin)

%% ------����
BodyLength=360;
BodyHeight=15;
BottomBoardWidth=150;
BottomBoardHeight=10;

MiddleBoardWidth=150;
MiddleBoardHeight=10;

TopBoardWidth=120;
TopBoardHeight=10;

CylinderHeight=30;
CylinderRadius=3;

TopCylinderHeight=20;
TopCylinderRadius=3;

MotorRadius=18;
MotorHeight=52;

HatRadius=3;
HatHeight=8;
AxisDis=600;%���

AirscrewLength=290;
AirscrewWidth=10;
AirscrewHeight=2;

%% ------����
MultiRotor=CreateComponent();

%% ------�������
%�װ�
BottomBoard=GetBox(BottomBoardWidth,BottomBoardWidth,BottomBoardHeight,[0 0 -BottomBoardHeight/2 0]');

%��֧��
offset=BottomBoardWidth/2-CylinderRadius*3;
offsetHeight=CylinderHeight/2;
BottomCylinder1=GetCylinder(CylinderRadius,CylinderHeight,30,[offset offset  offsetHeight 0]');
BottomCylinder2=GetCylinder(CylinderRadius,CylinderHeight,30,[-offset offset  offsetHeight 0]');
BottomCylinder3=GetCylinder(CylinderRadius,CylinderHeight,30,[-offset -offset offsetHeight 0]');
BottomCylinder4=GetCylinder(CylinderRadius,CylinderHeight,30,[offset -offset  offsetHeight 0]');

%�а�
MiddleBoard=GetBox(MiddleBoardWidth,MiddleBoardWidth,MiddleBoardHeight,[0 0 MiddleBoardHeight/2+CylinderHeight 0]');

%��֧��
offset=TopBoardWidth/2-CylinderRadius*3;
offsetHeight=CylinderHeight+MiddleBoardHeight+TopCylinderHeight/2;
TopCylinder1=GetCylinder(TopCylinderRadius,TopCylinderHeight,30,[offset offset  offsetHeight 0]');
TopCylinder2=GetCylinder(TopCylinderRadius,TopCylinderHeight,30,[-offset offset offsetHeight 0]');
TopCylinder3=GetCylinder(TopCylinderRadius,TopCylinderHeight,30,[-offset -offset offsetHeight 0]');
TopCylinder4=GetCylinder(TopCylinderRadius,TopCylinderHeight,30,[offset -offset offsetHeight 0]');

%�ϰ�
offsetHeight= MiddleBoardHeight+CylinderHeight+TopCylinderHeight+TopBoardHeight/2;
TopBoard=GetBox(TopBoardWidth,TopBoardWidth,TopBoardHeight,[0 0 offsetHeight 0]');

%���� ˳ʱ��
Body1=GetBox(BodyLength,BodyHeight,BodyHeight,[BodyLength/2 0 BodyHeight/2 0]');
Body2=GetBox(BodyHeight,BodyLength,BodyHeight,[0 BodyLength/2 BodyHeight/2 0]');
Body3=GetBox(BodyLength,BodyHeight,BodyHeight,[-BodyLength/2 0 BodyHeight/2 0]');
Body4=GetBox(BodyHeight,BodyLength,BodyHeight,[0 -BodyLength/2  BodyHeight/2 0]');

%���
offsetX=AxisDis/2;
offHeight=MotorHeight/2;
Motor1=GetCylinder(MotorRadius,MotorHeight,30,[offsetX 0 offHeight 0]');
Motor2=GetCylinder(MotorRadius,MotorHeight,30,[0 offsetX offHeight 0]');
Motor3=GetCylinder(MotorRadius,MotorHeight,30,[-offsetX 0 offHeight 0]');
Motor4=GetCylinder(MotorRadius,MotorHeight,30,[0 -offsetX offHeight 0]');

%ñ
offsetX=AxisDis/2;
offHeight=MotorHeight+HatHeight/2;
Hat1=GetCylinder(HatRadius,HatHeight,30,[offsetX 0 offHeight 0]');
Hat2=GetCylinder(HatRadius,HatHeight,30,[0 offsetX offHeight 0]');
Hat3=GetCylinder(HatRadius,HatHeight,30,[-offsetX 0 offHeight 0]');
Hat4=GetCylinder(HatRadius,HatHeight,30,[0 -offsetX offHeight 0]');

%��
Airscrew1=GetBox(AirscrewWidth,AirscrewLength,AirscrewHeight,[offsetX 0 offHeight 0]');
Airscrew2=GetBox(AirscrewLength,AirscrewWidth,AirscrewHeight,[0 offsetX offHeight 0]');
Airscrew3=GetBox(AirscrewWidth,AirscrewLength,AirscrewHeight,[-offsetX 0 offHeight 0]');
Airscrew4=GetBox(AirscrewLength,AirscrewWidth,AirscrewHeight,[0 -offsetX offHeight 0]');

%����ϵ
Coord=GetCoord(500);

%% ------�����
%�װ�
MultiRotor=AddComponent(MultiRotor,BottomBoard,'Box','g');

%����
MultiRotor=AddComponent(MultiRotor,Body1,'Box','k');
MultiRotor=AddComponent(MultiRotor,Body2,'Box','k');
MultiRotor=AddComponent(MultiRotor,Body3,'Box','k');
MultiRotor=AddComponent(MultiRotor,Body4,'Box','k');

%��֧��
MultiRotor=AddComponent(MultiRotor,BottomCylinder1,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,BottomCylinder2,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,BottomCylinder3,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,BottomCylinder4,'Cylinder','m');

%�а�
MultiRotor=AddComponent(MultiRotor,MiddleBoard,'Box','g');

%��֧��
MultiRotor=AddComponent(MultiRotor,TopCylinder1,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,TopCylinder2,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,TopCylinder3,'Cylinder','m');
MultiRotor=AddComponent(MultiRotor,TopCylinder4,'Cylinder','m');

%�ϰ�
MultiRotor=AddComponent(MultiRotor,TopBoard,'Box','g');

%���
MultiRotor=AddComponent(MultiRotor,Motor1,'Cylinder',[0.8 0.6 0.5]);
MultiRotor=AddComponent(MultiRotor,Motor2,'Cylinder',[0.8 0.6 0.5]);
MultiRotor=AddComponent(MultiRotor,Motor3,'Cylinder',[0.8 0.6 0.5]);
MultiRotor=AddComponent(MultiRotor,Motor4,'Cylinder',[0.8 0.6 0.5]);

%ñ
MultiRotor=AddComponent(MultiRotor,Hat1,'Cylinder','y');
MultiRotor=AddComponent(MultiRotor,Hat2,'Cylinder','y');
MultiRotor=AddComponent(MultiRotor,Hat3,'Cylinder','y');
MultiRotor=AddComponent(MultiRotor,Hat4,'Cylinder','y');

%��
color=[0.6 0.6 0.6];
MultiRotor=AddComponent(MultiRotor,Airscrew1,'Box',color);
MultiRotor=AddComponent(MultiRotor,Airscrew2,'Box',color);
MultiRotor=AddComponent(MultiRotor,Airscrew3,'Box',color);
MultiRotor=AddComponent(MultiRotor,Airscrew4,'Box',color);

%����ϵ
MultiRotor=AddComponent(MultiRotor,Coord,'Coord','b');

if nargin>0
    MultiRotor=TransComponent(varargin{1},MultiRotor);
end
if nargin>1
    MultiRotor=TransComponent(eye(4)*varargin{2},MultiRotor);
end
end