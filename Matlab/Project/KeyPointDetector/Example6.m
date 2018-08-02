%% 例子6 创建数据库
%% 说明
%%
%% ------读图
   I=imread('../../TestData/Images/Freak1.jpg');
   TestImageFileName='../../TestData/Images/Freak1.jpg';
   DatabaseFileName='../../TestData/Database/Database.mat';
%% ------参数
   width=15; %patch width
%% 提取方式
   Type='c'; %圆域
   D=getD(width,Type);
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:pi/2:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/8:pi/8:pi*2;%0:1:0;%
   N=getN({RangeLamda,RangeT,RangePsi,RangePhi});
%% 加载数据库
   Database=loadDatabase(DatabaseFileName);
   DataVectors=getDataVectorsFromDatabase(Database,D,N);
   if isempty(DataVectors)==1
       disp('Null!\n');
       return;
   end
   
   [N,M]=size(DataVectors);
   SubM=20;
   SubDataVectors=getSubDataVectors(DataVectors,SubM,round(N/3));
   
   RecoverPatchSet=dataVectors2PatchSet(SubDataVectors,width,Type);
   [ShowMat] = getShowPatchesMat(RecoverPatchSet);
   figure(2);
   imshow(ShowMat);