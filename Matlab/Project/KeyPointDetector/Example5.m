%% 例子5 创建数据库
%% 说明
%%
%% ------读图
   I=imread('../../TestData/Images/Freak1.jpg');
   TestImageFileName='../../TestData/Images/Freak1.jpg';
   DatabaseFileName='../../TestData/Database/Database.mat';
%% ------参数
   width=15; %patch width
   r=2;
%% 提取方式
   Type='c'; %圆域
%% 仿射Patch参数
   %生成仿射矩阵集
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:pi/2:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/8:pi/8:pi*2;%0:1:0;%
%% ------dvParam
   proParam.ProMethod='Normal';%'Discrete';%'Binary';%
   proParam.DiscreteNum=4;
   proParam.GradMethod='Sobel';
   interval=90;
   dvParam.width=width;
   dvParam.Type=Type;
   dvParam.r=r;
   dvParam.interval=interval;
   dvParam.proParam=proParam;
   
   [ DataVectors,D, AffinePatchSet]=getDataVectors(I,{RangeLamda,RangeT,RangePsi,RangePhi},dvParam);
   Database=cell(1000,1000);
   [N,M]=size(DataVectors);
%%
   RecoverPatchSet=dataVectors2PatchSet(DataVectors,width,Type);
   [ShowMat] = getShowPatchesMat(RecoverPatchSet);
   figure(1);
   imshow(ShowMat);
%% ------加入数据库
   Database=addDataVectors2Database(Database,DataVectors,D,N);
%% ------保存数据库
   save(DatabaseFileName,'Database');
   fprintf('D:%d\n',D);
   fprintf('N:%d\n',N);