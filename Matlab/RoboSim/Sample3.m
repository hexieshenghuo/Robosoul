%% �������������˻�ģ�Ͳ���ʾ

%% ����
multiRotor=GetMultiRotor();
T=Rot(pi/18,'x')*Rot(pi/8,'y')*Rot(pi/6,'z');
multiRotor=TransComponent(eye(4),multiRotor);

DrawComponent(multiRotor);

SetShowState(500);