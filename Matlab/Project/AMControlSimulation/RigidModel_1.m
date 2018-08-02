%% 刚体脚本模型

 %%
   w=6;
   r=3;
 
   frm.m=1;
   frm.I=eye(3)/6*frm.m;
   
   frm.Euler=[0;0;0];
   frm.dEuler=[0;0;0];
   frm.Je_b=EulerJacobian(frm.Euler,'xyz','b');
   frm.Je_w=EulerJacobian(frm.Euler,'xyz','w');
   
   frm.R=eye(3); 
   frm.P=[0;1;0];
   frm.K=eye(3);
   
   frm.W_w=[0;0;-w];
   frm.W_b=[0;0;-w];
  
   frm.V_w=[w*r;0;0];
   frm.V_b=[w*r;0;0];

   frm.Omi_w=[0;0;0];
   frm.Omi_b=[0;0;0];
   frm.Acc_w=[0;0;0];
   frm.Acc_b=[0;0;0];
   
   F1=[0;-r*w^2;0]*1;
   frm.F=[F1];
   frm.r=[[0;0;0]];
   frm.T =[0;0;0];
   frm.SumF =[];
   frm.SumT =[];
   frm.dt=0.05;
   frm.Model3d={};