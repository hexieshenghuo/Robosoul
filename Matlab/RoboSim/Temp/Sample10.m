%% Componet�÷�
%����AddComponet�Ⱥ������������ͬһ����ϵ����Բ���Ĺ̼�

%% ����
%����Բ��
Cylinder=GetCylinder(5,9,30,[0 0 0 0]');% ����1,4,6,6

%���ɺ���
%Box=GetBox(5,10,20,[20 2 3 0]');
SL=GetSanleng(5,10,20,[20 2 3 0]');

%�������
Base=CreateComponent();
%�����������
Base=AddComponent(Base,Cylinder,'Cylinder',[0 0 0.6]);
Base=AddComponent(Base,SL,'SL','r');

%���������任
NewBase=TransComponent(Rot(pi/3,'y'),Base);

%�����
DrawComponent(NewBase);
%���ù��Ч��
SetShowState(20);