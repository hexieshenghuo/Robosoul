%% ����1 ѵ������
%% 
clear all;
%% ------------������Ʊ���
   IsRead=1;%
   DataVectorsFileName='DataVectors.mat';
%% ------------��ȡͼ��
   I=imread('G:\RoboSoul\TestData\Images\Freak1.jpg');
   G=rgb2gray(I);
   [Height,Width]=size(G);
%% ------------����ѵ������
% ���ɵ�����
   width=7; %patch width
   r=2;       %ȡPatch����Ϊ�˷���
   Range=[width*r*2 Width-2*r*width width*r*3 Height-3*r*width];
   d=10;       %�������
   Points=getSamplePoints(Range,d);
   
   intvel=10; %��������
   SubPoints=Points(:,1:intvel:length(Points));%�Ӳ������г�ȡһ����
   
if IsRead==0; 
    
%---------����ԭʼPatch
   SourcePatchSet= getSourcePatchSet(G,SubPoints,width,r);
%---------����Patch��������
   RangeLamda=1:1:1;
   RangeT=1:1:1;
   RangePsi=0:1:0;
   RangePhi=pi/4:pi/4:pi*2;
 
   %������󼯺�
   TSet=getAffineMatSet(RangeLamda,RangeT,RangePsi,RangePhi);%����任����
   %��ԭʼ��PatchתΪ����Patch����
   AffinePatchSet=getAffinePatchSet(SourcePatchSet,TSet,width);%����Patch����

%------���ݸ�ʽת��
   param.width=width;
   param.Type='c';
   DataVectors=data2Vectors(AffinePatchSet,param);
%------�洢DataVectors
   save(DataVectorsFileName,'DataVectors');

else
   DataVectors=loadDataVectors(DataVectorsFileName);
end

%------Ԥ��������

%% ------------��ʾ����
   %% ת�� ��ʾ
   [N,M]=size(DataVectors);
   Show=[];
   for j=1:M
       show=[];
       for i=1:N
%           show=[show AffinePatchSet{i,j}];
       end
       Show=[Show;show];
   end
%   figure(2);
%    imshow(Show);

%% ------------��ʼ���������
   D=length(DataVectors{1,1});
   NumH=3;   %
   a=0.001;  %�߼��������ű���ֵ
   NetParam=initialNetParam(DataVectors,D,NumH,a);
   %NetParam=loadNetParam('NetParam_H6_Wid11.mat');
   
%% ------------ѵ������
%------��ʼ��
   objParam.Gamma=0.5;
   objParam.DataVectors=DataVectors;
   objParam.D=D;
   objParam.H=NumH;
   objParam.a=a;
   
   XDim=getParamDim(D,NumH);
   H=eye(XDim);
   WolfeParam=getWolfeParam();
   Erros=[];
   
   K=9; %Ѱ�Ŵ���
   
   RandStep=1000;%�������;
   
%------ѵ��ѭ��
   bfgsParam.WolfeParam=WolfeParam;
   bfgsParam.lamda=0.0003;
   
   GDParam.WolfeParam=WolfeParam;
   GDParam.lamda=10;
   X=netParam2Vector(NetParam);
   [fk,gk]=objFunc(X,objParam);
   Erros=[Erros fk];
   for k=1:K 
       %��ʾ���
       figure(1);
       plot(Erros);
       if norm(gk)<0.1
           disp('g̫С��');
       end
       str=sprintf('�ݶ�ģ��%f',norm(gk));
       disp(str);
       if fk<0.1
            save('NetParam.mat','NetParam');
           break;
       end
       X=netParam2Vector(NetParam);%ת��Ϊ����
%      [X,H,fk,gk] = BFGS(@objFunc,X,objParam,H,bfgsParam,'NoWolfe','Show');
       
       [X,fk,gk] = GD(@objFunc,X,objParam,GDParam,'NoWolfe');
       Erros=[Erros fk];
       NetParam=vector2NetParam(X,D,NumH,objParam.a);%ת��Ϊ����
   end
   
   disp(fk);
   Y=getY(DataVectors,NetParam);
   By=Y>=0.5;
   figure(2);
   imshow(By);