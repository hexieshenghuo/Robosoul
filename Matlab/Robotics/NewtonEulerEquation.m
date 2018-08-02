%% 用于ode求解的Newton-Euler方程函数 
%%
function [ dy ] = NewtonEulerEquation( ~, y ,F,m,I,tor )
 
   Vb=y(1:3);
   Wb=y(4:6);
   Euler=y(7:9);
   P=y(10:12);
   
   invI=inv(I);
   
   F1=1/m*F+Sw(Wb)*Vb;
   F2=invI*(tor - Sw(Wb)*I*Wb);
   Je_b=EulerJacobian(Euler,'xyz','b');
   Jb_e=inv(Je_b);
   F3=Jb_e*Wb;
   Rx=Rot(Euler(1),'x',3);
   Ry=Rot(Euler(2),'y',3);
   Rz=Rot(Euler(3),'z',3);
   R=Rx*Ry*Rz;
   
   F4=R*Vb;
   
   dy=[F1;F2;F3;F4];
   
end

