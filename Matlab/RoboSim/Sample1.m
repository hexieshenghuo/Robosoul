%% Componet�÷�
%����AddComponet�Ⱥ������������ͬһ����ϵ����Բ���Ĺ̼�

%% ����
%����Բ��
Cylinder=GetCylinder(5,9,300,[0 0 0 0]');

%���ɺ���
Box=GetBox(5,10,20,[20 2 3 0]');

%�������
Base=CreateComponent();

%�����������
Base=AddComponent(Base,Cylinder,'Cylinder',[0 0 0.6]);
Base=AddComponent(Base,Box,'Box','r');

%���������任
Base=TransComponent(Rot(pi/3,'y'),Base);

%�����
DrawComponent(Base);
%���ù��Ч��
SetShowState(30);