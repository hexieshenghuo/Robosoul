P = GetCylinder(3,8,1000,[0 0 0 0]');% ����һ��������ԭ���Բ���ĵ�
C= GetCoord(18);%��һ������ϵ

P=TransCylinder(Rot(pi/3,'y'),P);%�任,��Xpi/3
C=TransCoord(Rot(pi/3,'y'),C);%�任,��Xpi/3
DrawCoord(C,1);
DrawCylinder(P,'r');
SetShowState(20);