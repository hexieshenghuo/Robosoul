%% ����RBF���������� H ����C��s���ݶ� dHi/dci
%% ˵��
% h: ĳһ���ڵ�ֵ 
%
function [ dC,ds ] = dH( h, X,C,s)

  dC=h*(X-C)/s^2;
  ds=h*norm(X-C)^2/s^3;

end