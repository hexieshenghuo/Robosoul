%% 利用PID控制四旋翼姿态和高度
%%

%% 初始化
   ControlPeriod=0.02;
   dt=0.0002;
   UpdateNum=ControlPeriod/dt; %每一次控制更新模型次数
   
   PoseT= eye(3);%期望位姿
   
   RunTime=12;
   RunNum=RunTime/ControlPeriod;
   
%% 导入模型

   QuadrotorFileName = 'QuadrotorControlScript.m';
   qm=qmLoadModel(QuadrotorFileName);
   qm.rm.dt=dt;
   
   MeanF=qm.rm.m*9.8/8*1;
   MeanW=qm.rm.m*9.8/2/qm.Ktf;

% PID参数
   PitchKp=9; % X
   PitchKi=0.8; % X
   PitchKd=1.8;%1; % X

   e=[0;0];
   De=[0;0];
   Se=[0;0];

%% 控制循环

euler=zeros(3,RunNum);
Noise=zeros(3,RunNum);

   figure(1);
   for i=1:RunNum
      %% 控制
      
      %% 计算误差
      [ w, theta] = R2KRotParam(qm.rm.R );
      E=w*theta;
      E=-E(1:2);
      
      de= (E-e)/ControlPeriod;
      Se=Se+E*ControlPeriod;
      e=E;

      t1=pidController(PitchKp,PitchKi,PitchKd,e(1),Se(1),de(1));
      t2=pidController(PitchKp,PitchKi,PitchKd,e(2),Se(2),de(2));
      
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
      maxT=0.6;
      RandTorque=maxT*rand(3,1);
%     RandTorque(2,1)=0;
      RandTorque(3,1)=0;
%     qm = qmAddDriver(qm, [0; 0; 0],[1;0;0],RandTorque );
  
      qm.rm.T= [qm.rm.T RandTorque];
      qm.rm.T= [qm.rm.T -0.1*RandTorque];
      
      for j=1:UpdateNum
          %% 控制更新
           qm.rm=rmUpdate(qm.rm);   
      end
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
      euler(:,i)=qm.rm.Euler;
   end
   figure(2);
   t=0:length(euler)-1;
   plot(t*ControlPeriod,euler.'/pi*180);
      
   save 'E2.mat' euler;
      figure(3);
      plot(Noise.');