%% Sample3 ����Patch������ȡ��������ϲ�
%% ˵��
%% 
%% ------����
   width=19; %patch width
   r=2;       %ȡPatch����Ϊ�˷���
   M=20;      %��Ҫ�ĵ���
%% ------��ͼ
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Wid]=size(G);
%% ------���ɵ�
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=30;       %�������
   Points=getSamplePoints(Range,d); 
   SubPoints1=sampleFromPoints(Points,M);   
   SubPoints2=sampleFromPoints(Points,M);
%% ------ԭʼPatch��������
   SPSet1=getSourcePatchSet(G,SubPoints1,width,r);
   SPSet2=getSourcePatchSet(G,SubPoints2,width,r);
%% ------���ɷ���Patch����
   %���ɷ������
   RangeLamda=1:1:1;%0.9:0.1:1.1;
   RangeT=1:0.1:1;
   RangePsi=0:1:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/3:pi/3:pi*2;%0:1:0;%
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   
   %��ԭʼ��PatchתΪ����Patch����
   APSet1=getAffinePatchSet(SPSet1,TSet,width);%����Patch����
   APSet2=getAffinePatchSet(SPSet2,TSet,width);%����Patch����   
   
%% ------ת��
   p2vParam.width=width;
   p2vParam.Type='c';
   DataVectors1=patchSet2Vectors(APSet1,p2vParam);
   DataVectors2=patchSet2Vectors(APSet2,p2vParam);
   DataVectors=combineDataVectors(DataVectors1,DataVectors2);
   %% ��ת������
   RecoverPatchSet=dataVectors2PatchSet(DataVectors,width,p2vParam.Type);
   
%% ------��ʾ
   ShowMat= getShowPatchesMat(RecoverPatchSet);
   ShowMat=uint8(ShowMat);
   figure(1);
   imshow(ShowMat);