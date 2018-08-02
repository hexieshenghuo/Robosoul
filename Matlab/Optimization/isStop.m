%% 判断终止条件
%% 说明
% res：1为满足终止条件 0为不满足终止条件
% g:梯度值
% Thres：阈值
%%
function [res] = isStop(g,Thres)
res=(norm(g)<=Thres);
end