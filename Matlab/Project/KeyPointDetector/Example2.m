%% ����2 ѵ������
%% 
clear all;
clc;
%% ------------������Ʊ���
   IsRead=0;%
   DataVectorsFileName='DataVectors.mat';
   IsTest=1;
%% ------��ͼ
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   TestImageFileName='G:\RoboSoul\TestData\Images\Freak1.jpg';
   G=rgb2gray(I);
   G=double(G);
   [Height,Wid]=size(G);   
%% ------����
   width=9; %patch width
   M=500;      %��Ҫ�ĵ���
%% --------- Ѱ�Ŵ���   
   K=50;
%% ------Ԥ�������
   proParam.Method='Normal';%'Discrete';%'Binary';%
   proParam.DiscreteNum=4;
   proParam.GradMethod='Sobel';
%% ------��������
   method='GD';%'BFGS';%
   IsUseWolfePowell='NoWolfe';
   GDParam.lamda=1/1000;
%% ѵ������
   Gamma=0.1;
   NumH=10;   %
   StopThres=0.05;
%% ��ȡ��ʽ
   Type='c'; %Բ��
%% ------------��ȡDataVectors   
if IsRead==1
    DataVectors= loadDataVectors(DataVectorsFileName);
else
%% ------���ɵ�
   r=2;       %ȡPatch����Ϊ�˷���
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=width;       %�������
   Points=getSamplePoints(Range,d); 
   SubPoints=sampleFromPoints(Points,M);
%% ------ԭʼPatch��������
   SPSet=getSourcePatchSet(G,SubPoints,width,r);
%% ------���ɷ���Patch����
   %���ɷ������
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:1:0;%pi/3:pi/3:pi*2;%
   RangePhi=pi/36:pi/36:pi*2;%0:1:0;%
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   %��ԭʼ��PatchתΪ����Patch����
   APSet=getAffinePatchSet(SPSet,TSet,width);%����Patch����
%% Ԥ����Patch����
%    proParam.Method='GradMag';
%    proParam.DiscreteNum=8;
%    proParam.GradMethod='Sobel';
%    APSet=processPatchSet(APSet,proParam);
%    

   APSet=processPatchSet(APSet,proParam);
   
%% ------��ʾѵ��Patchͼ
   ShowMat= getShowPatchesMat(APSet);
   figure(3);
%    ShowMat=uint8(ShowMat*50);
   imshow(ShowMat);
%% ------ת��
   p2vParam.width=width;
   p2vParam.Type=Type;
   DataVectors=patchSet2Vectors(APSet,p2vParam);
   save(DataVectorsFileName,'DataVectors');
end
%% ------------��ʼ���������
   D=length(DataVectors{1,1});
   
   a=0.001;  %�߼��������ű���ֵ
   NetParam=initialNetParam(DataVectors,D,NumH,a);
   %NetParam=loadNetParam('NetParam_H6_Wid11.mat');
   
%% ------------ѵ��������ʼ��   
   objParam.Gamma=Gamma;
   objParam.DataVectors=DataVectors;
   objParam.D=D;
   objParam.H=NumH;
   objParam.a=a;
   objParam.IsTest=IsTest;   %���Ա�־
   
   XDim=getParamDim(D,NumH);
   H=eye(XDim);
   WolfeParam=getWolfeParam();
   Erros=[];
   
   bfgsParam.WolfeParam=WolfeParam;
   bfgsParam.lamda=0.03;
   bfgsParam.Test=IsTest;
   
   GDParam.WolfeParam=WolfeParam;
  
%% ---------ѵ��ѭ��
   X=netParam2Vector(NetParam);
   [fk,gk]=objFunc2(X,objParam);
   Erros=[Erros fk];
   for k=1:K 
       %��ʾ���
       figure(1);
       plot(Erros);

str=sprintf('�ݶ�ģ��%f\n',norm(gk));
disp(str);
       if fk<StopThres
            save('NetParam.mat','NetParam');
           break;
       end
       X=netParam2Vector(NetParam);%ת��Ϊ����
       switch method
           case 'BFGS'
               [X,H,fk,gk] = BFGS(@objFunc2,X,objParam,H,bfgsParam,IsUseWolfePowell,'Show');% 
           case 'GD'
               [X,fk,gk] = GD(@objFunc2,X,objParam,GDParam,IsUseWolfePowell);%'NoWolfe'
       end
       Erros=[Erros fk];
       NetParam=vector2NetParam(X,D,NumH,objParam.a);%ת��Ϊ����
   end
   
   disp(fk);
   Y=getY(DataVectors,NetParam);
   By=Y;
   figure(2);
   imshow(By);
   
    [N,M]=size(By);
    Str=sprintf('������%f',sum(sum(By))/N/M);
    disp(Str);
   
   %% ���Լ����
   figure(5);
   TestImage=imread(TestImageFileName); 
   image(TestImage);hold on;
   axis image;
   TestImage=rgb2gray(TestImage);
   Step=width;
   NetParam.width=width;
   NetParam.Type=Type;
   NetParam.DetectMethod='sgn';
   NetParam.Method=proParam.Method;
   [Keypoints,N]=runDetect(TestImage,NetParam,Step);
      
   length(Keypoints);
   plot(Keypoints(1,:),Keypoints(2,:),'g.');hold on;