%% ����һ��������е�����ˣ�ArmLink����ģ��
%% ˵��
%% alǰ׺�ĺ��������һ����е������ɶ�ģ���armǰ׺�ĺ������������һ����е�۵�
% m:   ����
% I:   ���Ծ���
% dh:  ������ϵ�����һ������ϵ��D-H����������"�ڶ���"D-H����
% Tup����һ������ϵ�����������ı任,��Ϊ��һ������ϵ��T
% T:   Tup��A ��ǰ����ϵ�������������ϵ�ı任
% Aconst��A�еĳ���
% Avar��  A�еı���
% A��Aconst��Avar ��ǰ����ϵ�����һ���ı任����
% R��MR(A)
% Theta��   ��
% dTheta��  d��
% ddTheta�� dd��
% Pc������
% Vc��
% dVc��
% V��
% dV��
% W��
% dW��
% Pdown������ iPi+1 �¼���������ϵԭ���ڵ�ǰ����ϵ�µ�λ��
% fup��  �ϼ��������õ�ǰ����,���������������ϵ
% fdown���¼��������õ�ǰ����,���������������ϵ
% F:     ����
% G��    ���������������ϵ������
% Model3D:
% dt

function [ AL ] = alDefaultModel( )

   AL.dh=[0 0 0 0];
   AL.m=3;
   AL.I=eye(3)*m/6;
   AL.Tup=eye(4);
   AL.T=eye(4);
   AL.Aconst=eye(4);
   AL.Avar=eye(4);
   AL.A=Aconst*Avar;
   AL.R=MR(AL.A);
   AL.Theta=0;
   AL.dTheta=0;
   AL.ddTheta=0;
   AL.Pc=[0;0;0];
   AL.Vc=[0;0;0];
   AL.dVc=[0;0;0];
   AL.V=[0;0;0];
   AL.dV=[0;0;0];
   AL.W=[0;0;0];
   AL.dW=[0;0;0];
   AL.Pdown=[0;0;0];
   AL.fup=[0;0;0];
   AL.fdown=[0;0;0];
   AL.F=[0;0;0];
   g=-9.8;
   AL.G=MR(Tup*A)*[0;0;g*m];
   AL.Model3D={};
   AL.dt=0.001;
end