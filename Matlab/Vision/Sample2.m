%% Sample2 ����Patch������ȡ����ʾ
%% ˵��
%%
%% ------����
   width=25; %patch width
   r=3;       %ȡPatch����Ϊ�˷���
   M=5;      %��Ҫ�ĵ���
%% ------��ͼ
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Wid]=size(G);
%% ------���ɵ�
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=100;       %�������
   Points=getSamplePoints(Range,d); 
   SubPoints=sampleFromPoints(Points,M);
%% ------ԭʼPatch��������
   SPSet=getSourcePatchSet(G,Points,width,r);
%% ------���ɷ���Patch����
   %���ɷ������
   RangeLamda=0.8:0.1:1.2;
   RangeT=0.9:0.1:1.2;
   RangePsi=0:0:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/3:pi/3:pi*2;%0:1:0;%
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   %��ԭʼ��PatchתΪ����Patch����
   APSet=getAffinePatchSet(SPSet,TSet,width);%����Patch����   
   
%% ------ת��
   p2vParam.width=width;
   p2vParam.Type='r';
   DataVectors=patchSet2Vectors(APSet,p2vParam);
   
   %% ��ת������
   RecoverPatchSet=dataVectors2PatchSet(DataVectors,width,p2vParam.Type);
   
%% ------��ʾ
   ShowMat= getShowPatchesMat(RecoverPatchSet);
   ShowMat=uint8(ShowMat);
   figure(1);
   imshow(ShowMat);