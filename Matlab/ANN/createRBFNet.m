%% 创建一个RBF神经网络
%% 说明
% DimX :    输入变量X的维数
% DimY :    输出变量Y的维数
% NumHid：  隐层数
% C:        RBF函数中心 DimX×NumHid
% s:        RBF感受域   NumHid×1
% W：       线性层权值矩阵 NumHid×DimY, Y=W.'H W每列为H的权值
% l:        是否加入齐次项W0   y=W.'H + W0*l
function [ rbf ] = createRBFNet( DimX,NumHid,DimY,varargin)
   
   r=1;
   if nargin>4
       r=varargin{2};
   end
   rbf=struct('dimX',DimX,...
              'dimY',DimY,...
              'numHid',NumHid,...
              'C',rand(DimX,NumHid)*r,...
              'S',ones(NumHid,1)*r,...
              'W',rand(NumHid,DimY)*r,...
              'W0',rand(DimY,1)*r);
   rbf.l=0;
   if nargin>3
       rbf.l=varargin{1};
   end
end