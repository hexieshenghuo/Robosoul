%% sigmoid导数的简易求法
%参考： 中文版《神经网络原理》 第四章 （4.32） P118
% y sigmod的函数值
%%
function [d] = dSigmoid_y(y,a)
d=a*y.*(1-y);
end