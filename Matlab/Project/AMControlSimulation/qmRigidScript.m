 %%
   frm.m=2.5;% kg
   
   % 计算惯性张量矩阵

   frm.I=eye(3)/6;
   
   frm.Euler=[0;0;0];
   frm.dEuler=[0;0;0];
   frm.Je_b=EulerJacobian(frm.Euler,'xyz','b');
   frm.Je_w=EulerJacobian(frm.Euler,'xyz','w');
   
   frm.R=eye(3); 
   frm.P=[0;0;0];
   frm.K=eye(3);
   
   frm.W_w=[0;0;0];
   frm.W_b=[0;0;0];
  
   frm.V_w=[0;0;0];
   frm.V_b=[0;0;0];

   frm.Omi_w=[0;0;0];
   frm.Omi_b=[0;0;0];
   frm.Acc_w=[0;0;0];
   frm.Acc_b=[0;0;0];
   
   %% 初始力与力矩
   frm.F=[];
   frm.r=[];
   frm.T =[];
   frm.SumF =[];
   frm.SumT =[];
   
   frm.dt=0.02;
   
   frm.Model3d=qmCreateModel();
   