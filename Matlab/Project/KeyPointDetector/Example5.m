%% ����5 �������ݿ�
%% ˵��
%%
%% ------��ͼ
   I=imread('../../TestData/Images/Freak1.jpg');
   TestImageFileName='../../TestData/Images/Freak1.jpg';
   DatabaseFileName='../../TestData/Database/Database.mat';
%% ------����
   width=15; %patch width
   r=2;
%% ��ȡ��ʽ
   Type='c'; %Բ��
%% ����Patch����
   %���ɷ������
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
%% ------�������ݿ�
   Database=addDataVectors2Database(Database,DataVectors,D,N);
%% ------�������ݿ�
   save(DatabaseFileName,'Database');
   fprintf('D:%d\n',D);
   fprintf('N:%d\n',N);