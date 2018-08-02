%% 判断矩阵是否正定
%% 说明
% res：1为正定 0为非负定
%%
function [ res ] = isPositiveDefinite( Mat )
[R,p]=chol(Mat);
res=(p==0);
end

