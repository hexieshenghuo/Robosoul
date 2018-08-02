%% 更新rbf参数
%% 说明 支持两种参数转换模式[C; S; W] 与 X
% C:
% S:
% W:
% X: [C;S;W];

function [ rbf ] = rbfUnpack( rbf,varargin )
  
   if nargin>2 
       % 三个参数
       rbf.C=varargin{1};
       rbf.S=varargin{2};
       rbf.W=varargin{3};
       rbf.W0=varargin{4};
   else
       % X 一个向量
       X=varargin{1};
       pos=rbf.dimX*rbf.numHid;
       C=X(1:pos);
       S=X(pos+1:pos+rbf.numHid);
       pos=pos+rbf.numHid;
       W=X(pos+1:pos+rbf.numHid*rbf.dimY);
       pos=pos+rbf.numHid*rbf.dimY;
       W0=X(pos+1:end);
       
       rbf.C=reshape(C,rbf.dimX,rbf.numHid);
       rbf.S=S;
       rbf.W=reshape(W,rbf.numHid,rbf.dimY);
       rbf.W0=W0;
   end
       
end