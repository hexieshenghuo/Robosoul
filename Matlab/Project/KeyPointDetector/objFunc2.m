%% ѵ��ģ�͵�Ŀ�꺯��
%% ˵��
% NetParam��Ҫѵ�����������
% objParam:����DataVector��Gamma
% Gamma������������ ��
% DataVectors���ݵ�������ʽ��Ϊcell���� DataVectors{i,j}Ϊһ������
%
%%
function [f,g] = objFunc2(Vector,objParam,varargin)
%------------��ʼ��
    %��ȡ��ǰ����
    DataVectors=objParam.DataVectors;
    Gamma=objParam.Gamma;
    D=objParam.D;
    H=objParam.H;
    Gain=objParam.Gain;
    NetParam=vector2NetParam(Vector,D,H,objParam.a);
    [ Alpha,C,S,W,H,D,a] = unpackNetParam( NetParam );
    
    % ��ȡ������������
    [N,M]=size(DataVectors);
    X=DataVectors;%���ĵ����Ʊ�ʾһ��
%------------���㵱ǰ����ֵf
   %����yij
   y=zeros(N,M);
   z=zeros(N,M);
   for j=1:M
       for i=1:N
           [y(i,j),z(i,j)]=keypointDetector(X{i,j},NetParam,'sgn');
       end
   end
   
   %�����
   Miu=mean(y)';%��ΪM��1����
   if N==1
       Miu=y';
   end
   
   %�����
   Sigma=zeros(M,1);%M��1ά����
   for j=1:M
       s=norm(y(:,j)-Miu(j))^2;
       Sigma(j)=s;
   end
   Sigma=Sigma/N;
    
   %����f
   % ***��Ҫ�޸� ���޸�
   Miu_j=mean(y')'-Gamma;%ÿһ��任��i����ƽ��ֵ ΪN��1���� (1/M)��yij-��
   %Psi=1/(1-Gamma)^2;% (1-Gamma)/Gamma^2
   %Gain=1/Gamma;%1;%1/Gamma^2;%/Gamma;%1;%%^2;
   f=sum(Sigma) + norm(Miu_j)^2*Gain;% + mean(mean(1./(y-Gamma).^2)) -Psi;%
   
   g=[];
   if objParam.IsGradient==0
       g=0;
       return;
   end
%------------���㵱ǰ�ݶȵķ��� Alpha C S W 
   %���� d��j/dyij
   dSigma_dy=zeros(N,M);
   for j=1:M
       VectorY=y(:,j)-Miu(j);% yj-��j
       Sum=2*mean(VectorY)/N;%
       dsdy=2*VectorY/N - Sum;
       dSigma_dy(:,j)=dsdy;
   end
   % ����df/dy
   % ***��Ҫ�޸� ���޸�
   df_dy= dSigma_dy + 2*Gain/(M)*repmat(Miu_j,1,M);% + 2./(Gamma-y).^3;
   
%% ------����dy/dz
   dy_dz=ones(N,M);%3*z.^2;%

%% ---------����Pijh ΪH��M��Nά����   
   % ����Disijh,�� ��(h)X(ij)-C(h) DisΪN��M��H��cell ÿ��Cell��һ��H��1����
   Dis=cell(N,M,H);% ����˳��i j h
   P=zeros(H,N,M);           % ����˳��h i j 
   for i=1:N
       for j=1:M
           for h=1:H
               Dis{i,j,h}=Alpha(:,h).*X{i,j}-C(:,h);
               P(h,i,j)=funcRBF(X{i,j},C(:,h),S(h),Alpha(:,h));
           end
       end
   end
   
%% ------����dz/dW
   dz_dW=P; % H
   
%% ------����dz/dp H��1ά����
   dz_dp=W; 
%% ------����dp���ݶ�   
   %����dp/dC Ϊ
   %����dp/dAlpha
   %����dp/dS
   dp_dC=cell(N,M,H);
   dp_dAlpha=cell(N,M,H);
   dp_dS=zeros(H,N,M);
   for h=1:H
       for i=1:N
           for j=1:M
               %dp_dC
               dpdc=-1/S(h)^2*P(h,i,j)*Dis{i,j,h};
               dp_dC{i,j,h}=dpdc;
               
               %dp_dAlpha
               dpdalpha=dpdc.*X{i,j};
               dp_dAlpha{i,j,h}=dpdalpha;
               
               %dp_dS
               dpds=P(h,i,j)*norm(Dis{i,j,h})^2 / S(h)^3;
               dp_dS(h,i,j)=dpds;
           end
       end
   end
   
%% ---------����������� C S W���ݶ�
   df_dAlpha=zeros(D,H);
   df_dC=zeros(D,H);
   df_dS=zeros(H,1);
   df_dW=zeros(H,1);
   
   for h=1:H
       dfdalpha=zeros(D,1);
       dfdc=zeros(D,1);
       dfds=0;
       for i=1:N
           for j=1:M
               df_dz=df_dy(i,j)*dy_dz(i,j);
               df_dp=df_dz*dz_dp(h);
               %------�ۼӸ����ݶ�
               dfdalpha=dfdalpha + df_dp*dp_dAlpha{i,j,h};
               dfdc=dfdc + df_dp*dp_dC{i,j,h};
               dfds=dfds + df_dp*dp_dS(h,i,j);
               if h==1   %W��ѭ��H ���ֻ����һ��
                   df_dW=df_dW + df_dz*dz_dW(:,i,j);
               end
           end
       end
       %------�����ݶ���ز���
       df_dAlpha(:,h)=dfdalpha;
       df_dC(:,h)=dfdc;
       df_dS(h)=dfds;
   end
%% ---------ת��Ϊ������ʽ
   g= gradient2Vector(df_dAlpha,df_dC,df_dS,df_dW,D,H);
%% ------------����
if objParam.IsTest==1
    
    %% ���Φ�
    df_dAlpha=zeros(D,H);
    
    %% �۲�
    Str=sprintf('df_dW:%f\n',norm(df_dW));
    disp(Str);
    
    Str=sprintf('df_dy:%f\n',norm(df_dy));
    disp(Str);
    
    Str=sprintf('dy_dz:%f\n',norm(dy_dz));
    disp(Str);
    
    Str=sprintf('max(z):%f min(z):%f\n',max(max(z)),min(min(z)));
    disp(Str);
    
    Str=sprintf('W:%f\n',norm(W));
    disp(Str);
    
end
end