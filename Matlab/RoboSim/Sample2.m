%% �ϲ��������

%% ����
% �����������
Component1=CreateComponent();
Component2=CreateComponent();

%�ֱ����һ������������
Box1=GetBox(1,2,3,[0 0 0 0]');
Component1=AddComponent(Component1,Box1,'Box','g');
Box2=GetBox(3,6,9,[12 1 5 0]');
Component2=AddComponent(Component2,Box2,'Box','b');

% �ϲ�
Component1=JointComponents(Component1,Component2);

%���������任
Component=TransComponent(Rot(pi/2.5,'z'),Component1);

%���ʹ��
DrawComponent(Component);
SetShowState(15);
