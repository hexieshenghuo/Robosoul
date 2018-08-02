%% 拟合BSpline曲线的目标函数
%% 说明
% Y=Data.Y ：待拟合曲线
% Dim=Data.Dim;曲线维数
% N=Data.N; ：控制点数
% k=Data.k; ：拟合成BSpline的精度
% Points=vector2Points(X,Dim,N);
% dtm=Data.dtm; ：寻找弧长比例参数的间隔,越小越精确但影响速度
% f: 函数值
% g: 函数梯度
%%
function [ f,g ] = fitObjFunc(X,Data,varargin)
%------初始化
   Y=Data.Y;
   Dim=Data.Dim;
   N=Data.N;
   k=Data.k;
   Points=vector2Points(X,Dim,N);
   dtm=Data.dtm;
   
%------计算Y对应的tm
   [tm] = findArcRatiotm(Y,Points,k,dtm);
   
%------计算f
   bsplineC=createBSplineCurve(Points,k,0.01,tm);
   dC=Y-bsplineC;
   M=length(dC);
   f=0;
   
   % 以下两种形式都可以 
%    for m=1:M
%         f=f+norm(dC(m))^2; %逐个累加
%    end
   f=norm(dC)^2; % 向量形式
   
   f=f/2;
%------计算g
   T=getT(N,k);
   for n=1:N
       BI(n,:)=B(tm,n,k,T);% BI为N×M矩阵，每行为一个点Pi对应的所有奇函数
   end
   
   df_dP=zeros(Dim,N);
   
   for n=2:N-1
       for i=1:Dim %点的维数
           df_dP(i,n)=sum(-dC(i,:).*BI(n,:));
       end
   end
   % 转换为向量
   g=points2Vector(df_dP);
end