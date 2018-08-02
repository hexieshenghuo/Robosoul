%% Demo5 曲线拟合测试
%% 说明
%%
%------生成样本曲线
   N=6;       % 控制点数
   Range=10;  % 采样范围
   k=3;       % BSpline阶数
   dt=0.05;  % T的间隔
   P=getControlPoints(N,Range);
   Y=createBSplineCurve(P,k,dt);
   
   pos=39;
   y=Y(:,pos);
   insertY=repmat(y,1,300);
   Y=[Y(:,1:pos) insertY Y(:,pos:end)];

%------设置参数
   fitN=9;
   fitk=4;
%------拟合
   optMethod='GD'; %'BFGS';%学习方法
   StopThres=0.01; %停止精度
   
   [Points] = getStartPoint(Y,fitN);%,'method','OnStart'

   Data.Y=Y;
   Data.Dim=2;
   Data.N=fitN;
   Data.k=fitk;
   Data.dtm=0.01;
   
   GDParam.WolfeParam=getWolfeParam();
   GDParam.lamda=0.01;
   GDParam.SearchParam=getLineSearchParam('Const',GDParam.lamda);
   
   bfgsParam.lamda=0.1;
   bfgsParam.WolfeParam=getWolfeParam();
   bfgsParam.Test=0;
   
   bfgsParam.SearchParam=getLineSearchParam('Const',GDParam.lamda);%'Const'
   
   X=points2Vector(Points);
   H=eye(length(X));
   IterNum=200;      %迭代次数
   for i=1:IterNum
     switch optMethod
         case 'GD'
         [X,f,g] = GD(@fitObjFunc,X,Data,GDParam,1);%,'NoWolfe'
         case 'BFGS'
         [X,H,f,gk] = BFGS(@fitObjFunc,X, Data, H,bfgsParam,1,'Show');%'NoWolfe',
     end

     fprintf('迭代次数: %d 误差：%f \n',i,f);
     
     if f<StopThres
         break;
     end
       
   end

%------显示
   drawControlPoints(P,'-r.');hold on;
   DrawCurve(Y);hold on;
   
   Points=vector2Points(X,Data.Dim,Data.N);
   fitCurve=createBSplineCurve(Points,fitk,0.01);
   
   drawControlPoints(Points);hold on;

   DrawCurve(fitCurve,'-.b.');hold on;
   
   figure(2);
   x=fitCurve(1,:);
   plot(x);
   