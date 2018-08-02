%% Sample1 ����Patch������ȡ
%% ˵��

%% ��ʼ����
Points=[[200; 220], [320; 320] ,[180; 120], [300; 100],[280; 200],[180; 380]];
width=25;

%% ��ͼ
I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
I=rgb2gray(I);
r=3;

%% ԭʼPatch��������
SPSet=getSourcePatchSet(I,Points,width,r);

%% ����Patch��������
RangeLamda=1:1:1;
RangeT=1:1:1;
RangePsi=0:1:0;
RangePhi=0:pi/180*60:pi*2;

%���ɷ������
TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����

%��ԭʼ��PatchתΪ����Patch����
APSet=getAffinePatchSet(SPSet,TSet,width);%����Patch����

%% ת�� ��ʾ
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

% ����ת����������
Param.width=width;
Param.Type='c';
DataVectors=patchSet2Vectors(APSet,Param);

DataMat=dataVectors2Mat(DataVectors);
DataMat=uint8(DataMat);

figure(1);
imshow(Show);
figure(2);
imshow(DataMat);

%% ����
imwrite(DataMat,'d.jpg','jpg');

%% ��ԭ
