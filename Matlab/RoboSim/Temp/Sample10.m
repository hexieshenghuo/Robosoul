%% Componet用法
%利用AddComponet等函数整体操作在同一坐标系下相对不变的固件

%% 例子
%生成圆柱
Cylinder=GetCylinder(5,9,30,[0 0 0 0]');% 侧面1,4,6,6

%生成盒子
%Box=GetBox(5,10,20,[20 2 3 0]');
SL=GetSanleng(5,10,20,[20 2 3 0]');

%创建组件
Base=CreateComponent();
%添加零件到组件
Base=AddComponent(Base,Cylinder,'Cylinder',[0 0 0.6]);
Base=AddComponent(Base,SL,'SL','r');

%对组件整体变换
NewBase=TransComponent(Rot(pi/3,'y'),Base);

%画组件
DrawComponent(NewBase);
%设置光的效果
SetShowState(20);