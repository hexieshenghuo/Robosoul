%% Demo8 ��̬��ʾ��Ϲ���
%% ˵��
%%
%% ������ϲ���
%% ˵��
%%
%------������������
   N=5;
   Range=10;
   k=4;
   dt=0.05;
   P=getControlPoints(N,Range);
   Y=createBSplineCurve(P,k,dt);
   
% ------������ʱ
%    pos=39;
%    y=Y(:,pos);
%    insertY=repmat(y,1,300);
%    Y=[Y(:,1:pos) insertY Y(:,pos:end)];
   
%------���ò���
   fitN=5;
   fitk=4;
   [Points] = getStartPoint(Y,fitN); % ,'method','OnStart'
%------���
   optMethod='GD';%'BFGS'; %ѧϰ����
   StopThres=0.0005; %ֹͣ����
   
   % ��������õ�Ŀ�꺯������
   Data.Y=Y;
   Data.Dim=2;
   Data.N=fitN;
   Data.k=fitk;
   Data.dtm=0.01;
   
   GDParam.WolfeParam=getWolfeParam();
   GDParam.lamda=0.006;
   GDParam.Test=0;
   GDParam.SearchParam=getLineSearchParam('Const',GDParam.lamda);
   
   bfgsParam.WolfeParam=getWolfeParam();
   bfgsParam.Test=0;
   
   X=points2Vector(Points);
   
   H=eye(length(X));
   IterNum=1200;      %��������
   
   figure(1);
   DelayTime=0.0001;
   Erros=[];
%------��ʾ
%------�������
   for i=1:IterNum
     switch optMethod
         case 'GD'
         [X,f,g] = GD(@fitObjFunc,X,Data,GDParam);%,'NoWolfe'
         case 'BFGS'
         [X,H,f,g] = BFGS(@fitObjFunc,X, Data, H,bfgsParam);
     end
     fprintf('��������: %d ��%f \n',i,f);
%      disp(f);
     
%------��̬��ʾ
     figure(1);
     drawControlPoints(P,'-r.');hold on;
     DrawCurve(Y);hold on;
     Points=vector2Points(X,Data.Dim,Data.N);
     fitCurve=createBSplineCurve(Points,fitk,0.01);
     
     drawControlPoints(Points,'-bo','b');
     DrawCurve(fitCurve,'-.b.');hold off;
     
     pause(DelayTime);
     
     Erros=[Erros f];
     figure(2);
     plot(Erros);
     if f<StopThres
         break;
     end     
   end  
   
   figure(3);
   fx=fitCurve(1,:);
   plot(fx,'color','r');hold on;
   
   x=Y(1,:);
   plot(x,'color','b');hold on;