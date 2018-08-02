%% 例子3 训练网络
%% 
clear all;
clc;
%% ------------程序控制变量
   IsRead=0;         %
   IsLoadNetParam=1; %
   DataVectorsFileName='DataVectors.mat';
   NetParamFileName='NetParam.mat';
   IsTest=0;
%% ------读图
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   TestImageFileName='G:\RoboSoul\TestData\Images\Freak1.jpg';
   G=rgb2gray(I);
   G=double(G);
   [Height,Wid]=size(G);   
%% ------参数
   width=9; %patch width
   M=50;      %需要的点数
%% --------- 寻优次数   
   K=5;
   LineSearchMethod='Simple2';%'Random';%'Back';%'Random';%;'Const';%'Const';
   SearchParam = getLineSearchParam( LineSearchMethod,0.03);
   GDParam.SearchParam=SearchParam;
   bfgsParam.SearchParam=SearchParam;
%% ------预处理参数
   proParam.ProMethod='Normal';%'Discrete';%'Binary';%
   proParam.DiscreteNum=4;
   proParam.GradMethod='Sobel';
%% ------方法参数
   method='GD';%'BFGS';%
%% 训练参数
   Gamma=0.2;
   NumH=4;   %
   StopThres=0.005;
   objParam.Gain=1;%1/Gamma;
   objParam.IsGradient=1;%IsGradient
%% 提取方式
   Type='c'; %圆域
%% 仿射Patch参数
   %生成仿射矩阵集
   RangeLamda=0.8:0.1:1.2;
   RangeT=0.8:0.1:1.2;
   RangePsi=pi/2:pi/2:pi*2;%pi/3:pi/3:pi*2;%
   RangePhi=pi/8:pi/8:pi*2;%0:1:0;%
%% ------------提取DataVectors   
if IsRead==1
    DataVectors= loadDataVectors(DataVectorsFileName);
else
%% ------生成点
   r=2;       %取Patch比例为了仿射
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=max(1,floor(width/2));       %采样间隔
   Points=getSamplePoints(Range,d); 
   SubPoints=sampleFromPoints(Points,M);
%% ------原始Patch集合生成
   SPSet=getSourcePatchSet(G,SubPoints,width,r);
%% ------生成仿射Patch集合
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵
   %将原始的Patch转为仿射Patch集合
   APSet=getAffinePatchSet(SPSet,TSet,width);%仿射Patch集合
%% 预处理Patch集合
   APSet=processPatchSet(APSet,proParam);
%% ------显示训练Patch图
   ShowMat= getShowPatchesMat(APSet);
   figure(3);
%  ShowMat=uint8(ShowMat*50);
   imshow(ShowMat);
%% ------转换
   p2vParam.width=width;
   p2vParam.Type=Type;
   [DataVectors,D]=patchSet2Vectors(APSet,p2vParam);
   save(DataVectorsFileName,'DataVectors');
end
%% ------------初始化网络参数
   a=0.001;  %逻辑函数缩放比例值
   if IsLoadNetParam>0
       NetParam=loadNetParam(NetParamFileName);
   else
       NetParam=initialNetParam(DataVectors,D,NumH,a);
   end
   %
%% ------------训练样本初始化   
   objParam.Gamma=Gamma;
   objParam.DataVectors=DataVectors;
   objParam.D=D;
   objParam.H=NumH;
   objParam.a=a;
   objParam.IsTest=IsTest;   %测试标志   
   XDim=getParamDim(D,NumH);
   H=eye(XDim);
   Erros=[];
%% ---------训练循环
   X=netParam2Vector(NetParam);
   [fk,gk]=objFunc2(X,objParam);
   Erros=[Erros fk];
   for k=1:K 
       %显示误差
       figure(1);
       plot(Erros);
str=sprintf('梯度模：%f\n',norm(gk));
disp(str);
       if fk<StopThres
            save('NetParam.mat','NetParam');
           break;
       end
       X=netParam2Vector(NetParam);%转换为向量
       switch method
           case 'BFGS'
               [X,H,fk,gk] = BFGS(@objFunc2,X,objParam,H,bfgsParam);% 
           case 'GD'
               [X,fk,gk,Lamda] = GD(@objFunc2,X,objParam,GDParam,'Test');
       end
       str=sprintf('迭代：%d 步长：%f\n',k,Lamda);
       disp(str);
       Erros=[Erros fk];
       NetParam=vector2NetParam(X,D,NumH,objParam.a);%转换为参数
   end
   NetParam = saveNetParam(NetParam,NetParamFileName,width,Type,'sgn',proParam.ProMethod);
   disp(fk);
   Y=getY(DataVectors,NetParam);
   By=Y;
   figure(2);
   imshow(By);
   
    [N,M]=size(By);
    Str=sprintf('比例：%f\n',sum(sum(By))/N/M);
    disp(Str);
   
   %% 测试检测器
   figure(5);
   TestImage=imread(TestImageFileName); 
   image(TestImage);hold on;
   axis image;
   TestImage=rgb2gray(TestImage);
   Step=max(9,width/2);

   
   [Keypoints,M]=runDetect(TestImage,NetParam,Step);
      
   N=length(Keypoints);
   str=sprintf('测试比例：%f',N/M);
   disp(str);
   
   str=sprintf('期望Gamma：%f',Gamma);
   disp(str);
   
   
   if N>0
       plot(Keypoints(1,:),Keypoints(2,:),'g.');hold on;
   end