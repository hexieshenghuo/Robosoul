%% ����7 ��ȡָ���ļ�����ͼ���Patch���������ݿ�
%% ˵��
%%
%% ------��ͼ
   ImagesPath='';
   DatabaseFileName='../../TestData/Database/Database.mat';
%% ------����
   width=15; %patch width
   r=2;
   Type='c'; %Բ��
%% ����Patch����
   %���ɷ������
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
%% ------��ʼ�����ݿ�   
   Database=cell(1000,1000);