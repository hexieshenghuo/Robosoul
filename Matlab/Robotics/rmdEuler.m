%% ����ŷ���ǵ��� dEuler
function [ rm ] = rmdEuler( rm )
   rm.dEuler= rm.Je_b\rm.W_b; % inv(rm.Je_b)*rm.W_b;
end