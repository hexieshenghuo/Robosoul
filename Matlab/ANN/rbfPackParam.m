%% 将RBF参数转写为用于优化计算的向量 rbf->[C;S;W];

function [ X ] = rbfPackParam( rbf )
   C=reshape(rbf.C,rbf.dimX*rbf.numHid,1);
   S=reshape(rbf.S,rbf.numHid,1);
   W=reshape(rbf.W,rbf.numHid*rbf.dimY,1);
   
   X=[C;S;W;rbf.W0];
end

