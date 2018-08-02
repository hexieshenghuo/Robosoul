%% 训练模型的目标函数
%% 说明
% NetParam需要训练的网络参数
% objParam:包括DataVector、Gamma
% Gamma：检测点数比例 γ
% DataVectors数据的向量形式，为cell类型 DataVectors{i,j}为一个向量
%
%%
function [f,g] = objFunc(Vector,objParam)

%------------初始化
    %提取当前参数
    DataVectors=objParam.DataVectors;
    Gamma=objParam.Gamma;
    D=objParam.D;
    H=objParam.H;
    
    NetParam=vector2NetParam(Vector,D,H,objParam.a);
    [ Alpha,C,S,W,H,D,a] = unpackNetParam( NetParam );
    
    % 提取样本的行列数
    [N,M]=size(DataVectors);
    X=DataVectors;%与文档控制表示一致
%------------计算当前函数值f
   %计算yij
   y=zeros(N,M);
   z=zeros(N,M);
   for j=1:M
       for i=1:N
           [y(i,j),z(i,j)]=keypointDetector(X{i,j},NetParam,'sgn');
       end
   end
   
   %计算μ
   Miu=mean(y)';%μ为M×1向量
   if N==1
       Miu=y';
   end
   
   %计算σ
   Sigma=zeros(M,1);%M×1维向量
   for j=1:M
       s=norm(y(:,j)-Miu(j))^2;
       Sigma(j)=s;
   end
   Sigma=Sigma/N;
    
   %计算f
   % ***需要修改 已修改
   Miu_j=mean(y')'-Gamma;%每一组变换（i）的平均值 为N×1向量 (1/M)Σyij-γ
   %Psi=1/(1-Gamma)^2;% (1-Gamma)/Gamma^2
   Gain=1/Gamma^2;
   f=Gain*sum(Sigma) + norm(Miu_j)^2*Gain;% + mean(mean(1./(y-Gamma).^2)) -Psi;%
    
%------------计算当前梯度的分量 Alpha C S W 
   %计算 dσj/dyij
   dSigma_dy=[];
   for j=1:M
       VectorY=y(:,j)-Miu(j);% yj-μj
       Sum=2*mean(VectorY)/N;%
       dsdy=2*VectorY/N - Sum;
       dSigma_dy=[dSigma_dy dsdy];
   end
   % 计算df/dy
   % ***需要修改 已修改
   df_dy= Gain*dSigma_dy + 2*Gain/(M)*repmat(Miu_j,1,M);% + 2./(Gamma-y).^3;
   
   % 计算dy/dz
   dy_dz=3*z.^2;
   
   %计算Pijh 为H×M×N维数组
   % 计算Disijh,即 α(h)X(ij)-C(h) Dis为N×M×H的cell 每个Cell是一个H×1向量
   Dis=cell(N,M,H);% 索引顺序i j h
   P=[];           % 索引顺序h i j 
   for i=1:N
       for j=1:M
           for h=1:H
               Dis{i,j,h}=Alpha(:,h).*X{i,j}-C(:,h);
               P(h,i,j)=funcRBF(X{i,j},C(:,h),S(h),Alpha(:,h));
           end
       end
   end
   
   %计算dz/dW
   dz_dW=P; % H
   
   %计算dz/dp H×1维向量
   dz_dp=W; 
   
   %计算dp/dC 为
   %计算dp/dAlpha
   %计算dp/dS
   dp_dC=cell(N,M,H);
   dp_dAlpha=cell(N,M,H);
   dp_dS=[];
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
   
   %---------计算参数（α C S W）梯度
   df_dAlpha=[];
   df_dC=[];
   df_dS=[];
   df_dW=zeros(H,1);
   
   for h=1:H
       dfdalpha=zeros(D,1);
       dfdc=zeros(D,1);
       dfds=0;
       for i=1:N
           for j=1:M
               df_dz=df_dy(i,j)*dy_dz(i,j);
               df_dp=df_dz*dz_dp(h);
               %------累加各个梯度
               dfdalpha=dfdalpha + df_dp*dp_dAlpha{i,j,h};
               dfdc=dfdc + df_dp*dp_dC{i,j,h};
               dfds=dfds + df_dp*dp_dS(h,i,j);
               if h==1   %W不循环H 因此只借用一次
                   df_dW=df_dW + df_dz*dz_dW(:,i,j);
               end
           end
       end
       %------计算梯度相关参数
       df_dAlpha=[df_dAlpha dfdalpha];
       df_dC=[df_dC dfdc];
       df_dS=[df_dS;dfds];
   end
%------------转换为向量形式
   g= gradient2Vector(df_dAlpha,df_dC,df_dS,df_dW,D,H);
end

