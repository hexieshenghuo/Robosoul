%% 作图

%% 初始化
   ControlPeriod=0.02;
   dt=0.002;
   UpdateNum=ControlPeriod/dt;%没一次控制更新模型次数
   RunTime=12;
   RunNum=RunTime/ControlPeriod;
  
   PoseT= eye(3);%期望位姿
   
   ControlCount=3;
   QuadrotorFileName = 'QuadrotorControlScript.m';

% PID参数
   Kp=[9;9;12];
   Ki=[1.8;1.8;1.8];
   Kd=[0.8;0.8;1.8];
   
   maxT=[1.8;1.0;0.6];
   DataName={'Data1.mat','Data2.mat','Data3.mat'};
   Data=cell(ControlCount,1);
%% 控制循环
   for i=1:ControlCount
       disp(i);
      %% 导入模型
       qm=qmLoadModel(QuadrotorFileName);
       qm.rm.dt=dt;  
       MeanF=qm.rm.m*9.8/8*1;
       MeanW=qm.rm.m*9.8/2/qm.Ktf;
       
       Data{i}=PitchRollPIDControl( qm,[Kp(i);Ki(i);Kd(i)],RunNum,maxT(i),ControlPeriod,MeanF,MeanW);
   end
%% 绘图
   figure(6);
   marker={'+','*','o'};
   Time=(0:RunNum-1)*ControlPeriod;
   for i=1:ControlCount
       data=Data{i};
       subplot(2,1,1);
       plot(Time,data(1,:)/pi*180,'marker',marker{i},'markersize',2);hold on;
   end
   xlabel('Time(s)');
   ylabel('Pitch(°)');
   legend('GoodPID','PID-Est','LC-Est');
   axis([0 RunTime*1.06 -30 20]);
   for i=1:ControlCount
       data=Data{i};
       subplot(2,1,2);
       plot(Time,data(2,:)/pi*180,'marker',marker{i},'markersize',2);hold on;
   end
   xlabel('Time(s)');
   ylabel('Roll(°)');
   legend('GoodPID','PID-Est','LC-Est');
   axis([0 RunTime*1.06 -30 20]);