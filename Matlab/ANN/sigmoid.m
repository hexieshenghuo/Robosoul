%% S 符号函数 这里用logistic函数
% alpha: 比例 控制符号函数坡度

%%
function [y] = sigmoid(x,alpha)
    y=1./(1+exp(-alpha*x));
end