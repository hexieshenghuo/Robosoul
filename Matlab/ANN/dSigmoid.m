%% sigmoid�����ĵ���

%%
function [dy] = dSigmoid(x,a)
dy=a*exp(-a*x)/(exp(-a*x) + 1)^2;
end

