%% ����3 ѵ������
%% 
clear all;
clc;
%% ------------������Ʊ���
   IsRead=0;         %
   IsLoadNetParam=1; %
   DataVectorsFileName='DataVectors.mat';
   NetParamFileName='NetParam.mat';
   IsTest=0;
%% ------��ͼ
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   TestImageFileName='G:\RoboSoul\TestData\Images\Freak1.jpg';
   G=rgb2gray(I);
   G=double(G);
   [Height,Wid]=size(G);   
%% ------����
   width=9; %patch width
   M=50;      %��Ҫ�ĵ���
%% --------- Ѱ�Ŵ���   
   K=5;
   LineSearchMethod='Simple2';%'Random';%'Back';%'Random';%;'Const';%'Const';
   SearchParam = getLineSearchParam( LineSearchMethod,0.03);
   GDParam.SearchParam=SearchParam;
   bfgsParam.SearchParam=SearchParam;
%% ------Ԥ�������
   proParam.ProMethod='Normal';%'Discrete';%'Binary';%
   proParam.DiscreteNum=4;
   proParam.GradMethod='Sobel';
%% ------��������
   method='GD';%'BFGS';%
%% ѵ������
   Gamma=0.2;
   NumH=4;   %
   StopThres=0.005;
   objParam.Gain=1;%1/Gamma;
   objParam.IsGradient=1;%IsGradient
%% ��ȡ��ʽ
   Type='c'; %Բ��
%% ����Patch����
   %���ɷ������
   RangeLamda=0.8:0.1:1.2;
   RangeT=0.8:0.1:1.2;
   RangePsi=pi/2:pi/2:pi*2;%pi/3:pi/3:pi*2;%
   RangePhi=pi/8:pi/8:pi*2;%0:1:0;%
%% ------------��ȡDataVectors   
if IsRead==1
    DataVectors= loadDataVectors(DataVectorsFileName);
else
%% ------���ɵ�
   r=2;       %ȡPatch����Ϊ�˷���
   Range=[width*r*2 Wid-2*r*width width*r*3 Height-3*r*width];
   d=max(1,floor(width/2));       %�������
   Points=getSamplePoints(Range,d); 
   SubPoints=sampleFromPoints(Points,M);
%% ------ԭʼPatch��������
   SPSet=getSourcePatchSet(G,SubPoints,width,r);
%% ------���ɷ���Patch����
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   %��ԭʼ��PatchתΪ����Patch����
   APSet=getAffinePatchSet(SPSet,TSet,width);%����Patch����
%% Ԥ����Patch����
   APSet=processPatchSet(APSet,proParam);
%% ------��ʾѵ��Patchͼ
   ShowMat= getShowPatchesMat(APSet);
   figure(3);
%  ShowMat=uint8(ShowMat*50);
   imshow(ShowMat);
%% ------ת��
   p2vParam.width=width;
   p2vParam.Type=Type;
   [DataVectors,D]=patchSet2Vectors(APSet,p2vParam);
   save(DataVectorsFileName,'DataVectors');
end
%% ------------��ʼ���������
   a=0.001;  %�߼��������ű���ֵ
   if IsLoadNetParam>0
       NetParam=loadNetParam(NetParamFileName);
   else
       NetParam=initialNetParam(DataVectors,D,NumH,a);
   end
   %
%% ------------ѵ��������ʼ��   
   objParam.Gamma=Gamma;
   objParam.DataVectors=DataVectors;
   objParam.D=D;
   objParam.H=NumH;
   objParam.a=a;
   objParam.IsTest=IsTest;   %���Ա�־   
   XDim=getParamDim(D,NumH);
   H=eye(XDim);
   Erros=[];
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
               [X,H,fk,gk] = BFGS(@objFunc2,X,objParam,H,bfgsParam);% 
           case 'GD'
               [X,fk,gk,Lamda] = GD(@objFunc2,X,objParam,GDParam,'Test');
       end
       str=sprintf('������%d ������%f\n',k,Lamda);
       disp(str);
       Erros=[Erros fk];
       NetParam=vector2NetParam(X,D,NumH,objParam.a);%ת��Ϊ����
   end
   NetParam = saveNetParam(NetParam,NetParamFileName,width,Type,'sgn',proParam.ProMethod);
   disp(fk);
   Y=getY(DataVectors,NetParam);
   By=Y;
   figure(2);
   imshow(By);
   
    [N,M]=size(By);
    Str=sprintf('������%f\n',sum(sum(By))/N/M);
    disp(Str);
   
   %% ���Լ����
   figure(5);
   TestImage=imread(TestImageFileName); 
   image(TestImage);hold on;
   axis image;
   TestImage=rgb2gray(TestImage);
   Step=max(9,width/2);

   
   [Keypoints,M]=runDetect(TestImage,NetParam,Step);
      
   N=length(Keypoints);
   str=sprintf('���Ա�����%f',N/M);
   disp(str);
   
   str=sprintf('����Gamma��%f',Gamma);
   disp(str);
   
   
   if N>0
       plot(Keypoints(1,:),Keypoints(2,:),'g.');hold on;
   end