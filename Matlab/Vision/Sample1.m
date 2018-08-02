%% Sample1 仿射Patch集合提取
%% 说明

%% 初始化点
Points=[[200; 220], [320; 320] ,[180; 120], [300; 100],[280; 200],[180; 380]];
width=25;

%% 读图
I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
I=rgb2gray(I);
r=3;

%% 原始Patch集合生成
SPSet=getSourcePatchSet(I,Points,width,r);

%% 仿射Patch集合生成
RangeLamda=1:1:1;
RangeT=1:1:1;
RangePsi=0:1:0;
RangePhi=0:pi/180*60:pi*2;

%生成仿射矩阵集
TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%仿射变换矩阵

%将原始的Patch转为仿射Patch集合
APSet=getAffinePatchSet(SPSet,TSet,width);%仿射Patch集合

%% 转换 显示
Size=size(APSet);
N=Size(1);
M=Size(2);
Show=[];
for j=1:M
    show=[];
    for i=1:N
        show=[show APSet{i,j}];
    end
    Show=[Show;show];
end

% 数据转向量（矩阵）
Param.width=width;
Param.Type='c';
DataVectors=patchSet2Vectors(APSet,Param);

DataMat=dataVectors2Mat(DataVectors);
DataMat=uint8(DataMat);

figure(1);
imshow(Show);
figure(2);
imshow(DataMat);

%% 保存
imwrite(DataMat,'d.jpg','jpg');

%% 还原
