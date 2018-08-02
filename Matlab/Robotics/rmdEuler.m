%% 更新欧拉角导数 dEuler
function [ rm ] = rmdEuler( rm )
   rm.dEuler= rm.Je_b\rm.W_b; % inv(rm.Je_b)*rm.W_b;
end