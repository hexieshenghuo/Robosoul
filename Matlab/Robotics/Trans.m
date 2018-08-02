%% 平移变换矩阵
%%
% D若为为4×1维列向量，最后一个数必须是1！
function [ Mat ] = Trans(D)
   l=length(D);
   if l==3
       Mat=[[1 0 0;0 1 0;0 0 1] D;[0 0 0 1]];
   else
       Mat=[eye(3);[0 0 0]];
       Mat=[Mat D];
   end
   
   Mat(4,:)=[0 0 0 1];% 为了方式D最后一个是0的误操作
end