function [ euler ] = PitchRollPIDControl( qm,Kpid,RunNum,maxT,ControlPeriod,MeanF,MeanW)
   
   Kp=Kpid(1);
   Ki=Kpid(2);
   Kd=Kpid(3);
  
   euler=zeros(3,RunNum);
   Noise=zeros(3,RunNum);

   e=[0;0];
   Se=[0;0];
   
   UpdateNum=ControlPeriod/qm.rm.dt;
   
   %% 控制
   for i=1:RunNum
      
      %% 计算误差
      [ w, theta] = R2KRotParam(qm.rm.R );
      E=w*theta;
      E=-E(1:2);
      
      de= (E-e)/ControlPeriod;
      Se=Se+E*ControlPeriod;
      e=E;

      t1=pidController(Kp,Ki,Kd,e(1),Se(1),de(1));
      t2=pidController(Kp,Ki,Kd,e(2),Se(2),de(2));
      
      dF1=t1/qm.l;
      dF2=t2/qm.l;
      
      f2=MeanF+0.5*dF1;
      f4=MeanF-0.5*dF1;
     
      f1=MeanF-0.5*dF2;
      f3=MeanF+0.5*dF2;
      
      w=[f1;f2;f3;f4]/qm.Ktf;
      
      w=max(min(w,qm.MaxW),0);
%     disp(w);
      
      qm=qmUpdateDriver( qm , w );
      
      % 加扰动
      RandTorque=maxT*rand(3,1);
%     RandTorque(2,1)=0;
      RandTorque(3,1)=0;
      Noise(:,i)= RandTorque;
%     qm = qmAddDriver(qm, [0; 0; 0],[1;0;0],RandTorque );
  
      qm.rm.T= [qm.rm.T RandTorque];
      
      for j=1:UpdateNum
          %% 控制更新
           qm.rm=rmUpdate(qm.rm);   
      end
      
       %{
       if ~isempty(qm.rm.Model3d)
           clf;
           T=MT(qm.rm.R,qm.rm.P);
           showModel=TransComponent(T,qm.rm.Model3d);
           DrawComponent(showModel);
           
           camlight;
           grid on;
           axis equal;
%            SetShowState(2);
           drawnow;
       end
       %}   
      
      euler(:,i)=qm.rm.Euler;
      
   end
   
   save DataName euler;
   
end

