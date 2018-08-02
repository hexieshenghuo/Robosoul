function [ rm ] = rmDynamics( rm )
   
   %% �����������
   rm=rmSumForce(rm);
   rm=rmSumTorque(rm);
   
   
   %% ����ode45 ��ode23
   
   %{
   tspan=[0 rm.dt];
   y0=[rm.V_b;rm.W_b;rm.Euler;rm.P];
   [t,y] = ode45(@(t,y) NewtonEulerEquation(t,y,rm.SumF,rm.m,rm.I,rm.SumT), tspan, y0);
   
   rm.V_b=y(end,1:3).';
   rm.W_b=y(end,4:6).';
   rm.Euler=y(end,7:9).';
   rm.P=y(end,10:12).';
   
   y=NewtonEulerEquation(0,y(end,:).',rm.SumF,rm.m,rm.I,rm.SumT);
   
   rm.Acc_b=y(1:3);
   rm.Omi_b=y(4:6);  
   %}
    
   %% ����ŷ������
   %{ %}  
   %% ����ţ��ŷ�����̼�����ٶ���Ǽ��ٶ�
   rm.Omi_b=rm.I\(rm.SumT - cross( rm.W_b, rm.I*rm.W_b) );
   rm.Acc_b=(rm.SumF - cross( rm.W_b, rm.m*rm.V_b) )/rm.m;

   %% �����ٶ�
   rm.V_b=rm.V_b + rm.dt*rm.Acc_b;
   rm.W_b=rm.W_b + rm.dt*rm.Omi_b;
  
end

