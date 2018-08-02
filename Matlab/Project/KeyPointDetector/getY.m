%% 生成 数据DataVector对应的Yij矩阵
%% %% 用于测试函数 求所有学习数据的y值
% DataVectors:数据
% Param：网络参数
%% 
function [Y] = getY(DataVectors,NetParam)
   [N,M]=size(DataVectors);
   Y=zeros(N,M);
   for i=1:N
       for j=1:M
           Y(i,j)=keypointDetector(DataVectors{i,j},NetParam,'sgn');
       end
   end
end