%% 第4个关节和连杆的参数

%%
   Model3dFileName='Link3dModelScript_4.m'; % 3d模型脚本m文件
   
   global amDH;
   falm.dh=amDH(4,:);
   falm.m=0.2; % 0.2kg
   falm.I=eye(3)*falm.m/6;
   
   falm.Aconst=Trans([falm.dh(1);0;0;1])*Rot(falm.dh(2),'x')*Trans([0;0;falm.dh(3);1]);% x x z
   falm.Avar=Rot(falm.dh(4),'z');
   falm.A=falm.Aconst*falm.Avar;
   falm.R=MR(falm.A);
   
   falm.Tup=eye(4);% 变量
   falm.T=falm.Tup*falm.A;  % 变量
   
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