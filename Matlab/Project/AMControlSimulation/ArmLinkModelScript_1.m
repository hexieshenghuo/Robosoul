%% ��1���ؽں����˵Ĳ���

%%
   Model3dFileName='Link3dModelScript_1.m'; % 3dģ�ͽű�m�ļ�
   
   global amDH;
   falm.dh=amDH(1,:);
   falm.m=0.2; % 0.2kg
   falm.I=eye(3)*falm.m/6;
   
   global h;
   falm.Aconst=Trans([0;0;-h;1])*Rot(pi/2,'x');
   falm.Avar=Rot(falm.dh(4),'z');
   falm.A=falm.Aconst*falm.Avar;
   falm.R=MR(falm.A);
   
   falm.Tup=eye(4);% ����
   falm.T=falm.Tup*falm.A;  % ����
   
   falm.Theta=falm.dh(4);
   falm.dTheta=0;
   falm.ddTheta=0;
   falm.Pc=[0;0;0];
   falm.Vc=[0;0;0];
   falm.dVc=[0;0;0];
   falm.V=[0;0;0];
   falm.dV=[0;0;0];
   falm.W=[0;0;0];
   falm.dW=[0;0;0];
   falm.Pdown=[0;0;0];
   falm.fup=[0;0;0];
   falm.fdown=[0;0;0];
   falm.F=[0;0;0];
   g=-9.8;
   falm.G=MR(falm.Tup*falm.A)*[0;0;g*falm.m];
   falm.dt=0.001;
   
   falm.Model3d=Load3dModel(Model3dFileName);