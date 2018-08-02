   %% һ�������е��ģ�Ͳ����ĵ�1���ű�
  
   %% 
   dt=0.02; %�������ʱ��(s)
   
   %% ---------Quadrotor
   QuadrotorFileName = 'QuadrotorScript.m';
   qm=qmLoadModel( QuadrotorFileName );
   qm.rm.dt=dt;
   
   %% ---------Manipulator
   %% DH��ṹ����
   global LinkLength;              % ������˳�����Ҫ�Ĳ����������global
   LinkLength=[0.18;0.18;0.15;0.03;0.06]; % ���˳��� 
   %Angle=[-pi/2;pi/2;0;0;0];     % �ؽڳ�ʼ�Ƕ�
   Angle=[-1.236;0.927;-1.017;0;0];
   global amDH;
   amDH=[ 0              0        0                             Angle(1);...
          LinkLength(1)  0        0                             Angle(2);...
          LinkLength(2)  -pi/2    0                             Angle(3);...
          0              -pi/2    LinkLength(3)                 Angle(4);...
          0              0        LinkLength(4)+LinkLength(5)   Angle(5)];
   
   %% Arm
   Arm.LinkNum=5;     %�ؽں����˵����� ���һ����ĩ��ִ�������̶���û�в���
   ArmLinkFileName={ 'ArmLinkModelScript_1.m',...
                     'ArmLinkModelScript_2.m',...
                     'ArmLinkModelScript_3.m',...
                     'ArmLinkModelScript_4.m',...
                     'ArmLinkModelScript_5.m'};
   
   for i=1:Arm.LinkNum
       Link(i)=alLoadModel(ArmLinkFileName{i});
       if i>1
            Link(i).Tup=Link(i-1).T;    
       end
       Link(i)=alUpdatePose( Link(i) );
       Link(i).dt=dt;
   end
  
   Arm.Link=Link;
   Arm.LinkLength=LinkLength;
   Arm.dt=dt;
   % ����
   Arm.Theta=Angle;
   Arm.dTheta=zeros(Arm.LinkNum,1);
   
   %% Jacobian����
   Arm.J_e2b=@Je2q; % ĩ�������ƽ̨������ϵ��Jacobian
   
   %% �ϳ�
   fam.qm=qm;
   fam.arm=Arm;
   
   %% ��������
   
   %% ״̬�۲�