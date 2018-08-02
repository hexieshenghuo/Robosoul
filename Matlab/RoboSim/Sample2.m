%% 合并组件例子

%% 例子
% 创建两个组件
Component1=CreateComponent();
Component2=CreateComponent();

%分别添加一个零件到两组件
Box1=GetBox(1,2,3,[0 0 0 0]');
Component1=AddComponent(Component1,Box1,'Box','g');
Box2=GetBox(3,6,9,[12 1 5 0]');
Component2=AddComponent(Component2,Box2,'Box','b');

% 合并
Component1=JointComponents(Component1,Component2);

%对组件整体变换
Component=TransComponent(Rot(pi/2.5,'z'),Component1);

%画和打光
DrawComponent(Component);
SetShowState(15);
