%% 计算RBF神经网络隐层 H 对于C和s的梯度 dHi/dci
%% 说明
% h: 某一个节点值 
%
function [ dC,ds ] = dH( h, X,C,s)

  dC=h*(X-C)/s^2;
  ds=h*norm(X-C)^2/s^3;

end