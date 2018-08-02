%% 例子7 提取指定文件夹中图像的Patch并存入数据库
%% 说明
%%
%% ------读图
   ImagesPath='';
   DatabaseFileName='../../TestData/Database/Database.mat';
%% ------参数
   width=15; %patch width
   r=2;
   Type='c'; %圆域
%% 仿射Patch参数
   %生成仿射矩阵集
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:pi/2:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/8:pi/8:pi*2;%0:1:0;%
   proParam.ProMethod='Normal';%'Discrete';%'Binary';%
   proParam.DiscreteNum=4;
   proParam.GradMethod='Sobel';
   interval=90;
%% ------dvParam
   dvParam.width=width;
   dvParam.Type=Type;
   dvParam.r=r;
   dvParam.interval=interval;
   dvParam.proParam=proParam;
   [ DataVectors,D, AffinePatchSet]=getDataVectors(I,{RangeLamda,RangeT,RangePsi,RangePhi},dvParam);
%% ------初始化数据库   
   Database=cell(1000,1000);