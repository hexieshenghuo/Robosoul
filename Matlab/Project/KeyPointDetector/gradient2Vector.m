%% 将各个参数梯度转为向量形式
%%
function [ gVector ] = gradient2Vector(dAlpha,dC,dS,dW,D,H)
% Alpha
   vectorAlpha=reshape(dAlpha,D*H,1);
% C
   vectorC=reshape(dC,D*H,1);
% S
   %无需
% W
   %无需
%存储
   gVector=[vectorAlpha;vectorC;dS;dW];
end