%% Demo7
%% ˵��
%%
%------������������
   N=6;
   Range=10;
   k=3;
   dt=0.01;
   P=getControlPoints(N,Range);
   hold off;
   Y=createBSplineCurve(P,k,dt);
   
   % �����ٶ�����
   dX=diff(Y(1,:));
   dY=diff(Y(2,:));
   Y=[dX;dY];
%------���ò���
   fitN=7;
   fitk=3;
   
%------���
   optMethod='GD'; %'BFGS';%ѧϰ����
   StopThres=0.001; %ֹͣ����
   
   [Points] = getStartPoint(Y,fitN);%,'method','OnStart'

   Data.Y=Y;
   Data.Dim=2;
   Data.N=fitN;
   Data.k=fitk;
   Data.dtm=0.08;
   
   GDParam.WolfeParam=getWolfeParam();
   GDParam.lamda=0.01;
   
   bfgsParam.lamda=0.1;
   bfgsParam.WolfeParam=getWolfeParam();
   bfgsParam.Test=0;
   
   X=points2Vector(Points);
   H=eye(length(X));
   IterNum=100;      %��������
   for i=1:IterNum
     switch optMethod
         case 'GD'
         [X,f,g] = GD(@fitObjFunc,X,Data,GDParam,'NoWolfe');%
         case 'BFGS'
         [X,H,f,gk] = BFGS(@fitObjFunc,X, Data, H,bfgsParam,1,'Show');%'NoWolfe',
     end
     disp(i);
     disp(f);
     if f<StopThres
         break;
     end
       
   end

%------��ʾ
   %drawControlPoints(P,'-r.');hold on;
   DrawCurve(Y,'--go',2);hold on;
   
   Points=vector2Points(X,Data.Dim,Data.N);
   fitCurve=createBSplineCurve(Points,fitk,0.01);
   
   drawControlPoints(Points);hold on;
   DrawCurve(fitCurve,'-.b.',3);hold on;