%% ���������е��ģ��
%% ����3Dģ�����������
%% ˵��
% M: һ�������е�۵�����ģ�͵ļ��Ͻṹ
function [ M ] = getAMModel( varargin )
   
   %% ---------�̶�����
   M.RotorNum=8;   % ������
   M.r=[1 0 0.6];  %
   
   global ArmTrans;
   ArmTrans=60;
   
   M.ArmTrans=[0 0 -ArmTrans 1]';    % ��е�ۻ�������Էɻ�������λ��
   LinkLength=[200 200 200 0];       % ��е�����˳���
   AerialScale=1.0;                  % �ɻ�ģ�ͱ���
   
   %% ---------״̬������ʼֵ
   %---------�ɻ�ƽ̨
   M.States.EulerAngles=[0 0 0]';       %[pi/3;pi/4;pi/6]; %�ɻ�ƽ̨ŷ����
   M.States.BasePos=[0;0;0];            %�ɻ�����λ��
   
   M.States.BaseBodyVel=[0;0;0];        %�ɻ������ٶ�
   M.States.BaseBodyDVel=[0 0 0]';      %�ɻ�������ٶ�
   
   M.States.BaseBodyW=[0;0;0];          %�ɻ�������ٶ�
   M.States.BaseBodyDW=[0;0;0];         %�ɻ�����Ǽ��ٶ�
   
   M.States.BaseResVel=[0;0;0];     %�ɻ���������ϵ�ٶ�
   M.States.BaseResDVel=[0 0 0]';   %�ɻ���������ϵ���ٶ�

   M.States.BaseResW=[0;0;0];     %�ɻ���������ϵ���ٶ�
   M.States.BaseResDW=[0;0;0];    %�ɻ�����Ǽ��ٶ�
   
   M.States.BaseRotMat=EulerRotMat(M.States.EulerAngles);
   M.States.BaseTrans=[M.States.BaseRotMat M.States.BasePos;[0 0 0 1]]; %�ɻ������������ϵ�任����
   
   %---------��е��ƽ̨
   M.States.Theta=[-pi/2 0 pi/2 0]';    % �ؽڽǶ�
   M.States.DTheta=[0 0 0 0]';          % �ؽڽ��ٶ�
   M.States.DDTheta=[0 0 0 0]';         % �ؽڽǼ��ٶ�
   M.States.DH=[M.States.Theta(1) 0 LinkLength(1) 0;...
                M.States.Theta(2) 0 LinkLength(2) -pi/2;...
                M.States.Theta(3) 0 0 pi/2;...
                M.States.Theta(4) LinkLength(3) 0 0];
   M.States.JointNum=length(M.States.Theta);
   [A, T]=updateTrans( M.States.DH );
   M.States.ArmA=A;
   M.States.ArmT=T;
   
   M.States.Coord0ToBase=Trans(M.ArmTrans)*Rot(pi/2,'x'); %��е������ϵ0���ɻ���������ϵ�ľ���
   
   M.States.EndPosToBase=Vp(M.States.Coord0ToBase*M.States.ArmT{M.States.JointNum});%ĩ��ִ������Էɻ�λ��
   M.States.EndPosToRes=Vp(M.States.BaseTrans*M.States.Coord0ToBase*M.States.ArmT{M.States.JointNum});%ĩ��ִ���������������ϵλ��
   
   M.States.EndVelToBody=[0 0 0]';
   M.States.EndVelToBase=[0 0 0]';
   M.States.EndVelToRes=[0 0 0]';
   
   M.States.EndWToBody=[0 0 0]';
   M.States.EndWToBase=[0 0 0]';
   M.States.EndWToRes=[0 0 0]';
   
   %% 3Dģ��
   M.Component=CreateComponent();
   % --------- �ɻ�3Dģ��
   AerialComponent=getAerialModel(M.States.BaseTrans,AerialScale);
   
   % --------- ��е��3Dģ��
   ArmComponent=getArmModel(M.States.ArmT,...
                            M.States.BaseTrans*M.States.Coord0ToBase,...
                            M.States.DH);
   M.Component=JointComponents(M.Component,AerialComponent);
   M.Component=JointComponents(M.Component,ArmComponent);
end