%% 例子1 训练网络
%% 
clear all;
%% ------------程序控制变量
   IsRead=1;%
   DataVectorsFileName='DataVectors.mat';
%% ------------获取图像
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Width]=size(G);
%% ------------生成训练样本
% 生成点坐标
   width=7; %patch width
   r=2;       %取Patch比例为了仿射
   Range=[width*r*2 Width-2*r*width width*r*3 Height-3*r*width];
   d=10;       %采样间隔
   Points=getSamplePoints(Range,d);
   
   intvel=10; %点采样间隔
   SubPoints=Points(:,1:intvel:length(Points));%从采样点中抽取一部分
   
if IsRead==0; 
    
%---------生成原始Patch
   SourcePatchSet= getSourcePatchSet(G,SubPoints,width,r);
%---------仿射Patch集合生成
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:1:0;
   RangePhi=pi/4:pi/4:pi*2;
 
   %仿射矩阵集合
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵
   %将原始的Patch转为仿射Patch集合
   AffinePatchSet=getAffinePatchSet(SourcePatchSet,TSet,width);%仿射Patch集合

%------数据格式转换
   param.width=width;
   param.Type='c';
   DataVectors=data2Vectors(AffinePatchSet,param);
%------存储DataVectors
   save(DataVectorsFileName,'DataVectors');

else
   DataVectors=loadDataVectors(DataVectorsFileName);
end

%------预处理样本

%% ------------显示样本
   %% 转换 显示
   [N,M]=size(DataVectors);
   Show=[];
   for j=1:M
       show=[];
       for i=1:N
%           show=[show AffinePatchSet{i,j}];
       end
       Show=[Show;show];
   end
%   figure(2);
%    imshow(Show);

%% ------------初始化网络参数
   D=length(DataVectors{1,1});
   NumH=3;   %
   a=0.001;  %逻辑函数缩放比例值
   NetParam=initialNetParam(DataVectors,D,NumH,a);
   %NetParam=loadNetParam('NetParam_H6_Wid11.mat');
   
%% ------------训练样本
%------初始化
   objParam.Gamma=0.5;
   objParam.DataVectors=DataVectors;
   objParam.D=D;
   objParam.H=NumH;
   objParam.a=a;
   
   XDim=getParamDim(D,NumH);
   H=eye(XDim);
   WolfeParam=getWolfeParam();
   Erros=[];
   
   K=9; %寻优次数
   
   RandStep=1000;%随机步长;
   
%------训练循环
   bfgsParam.WolfeParam=WolfeParam;
   bfgsParam.lamda=0.0003;
   
   GDParam.WolfeParam=WolfeParam;
   GDParam.lamda=10;
   X=netParam2Vector(NetParam);
   [fk,gk]=objFunc(X,objParam);
   Erros=[Erros fk];
   for k=1:K 
       %显示误差
       figure(1);
       plot(Erros);
       if norm(gk)<0.1
           disp('g太小了');
       end
       str=sprintf('梯度模：%f',norm(gk));
       disp(str);
       if fk<0.1
            save('NetParam.mat','NetParam');
           break;
       end
       X=netParam2Vector(NetParam);%转换为向量
%      [X,H,fk,gk] = BFGS(@objFunc,X,objParam,H,bfgsParam,'NoWolfe','Show');
       
       [X,fk,gk] = GD(@objFunc,X,objParam,GDParam,'NoWolfe');
       Erros=[Erros fk];
       NetParam=vector2NetParam(X,D,NumH,objParam.a);%转换为参数
   end
   
   disp(fk);
   Y=getY(DataVectors,NetParam);
   By=Y>=0.5;
   figure(2);
   imshow(By);