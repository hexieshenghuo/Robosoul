%% 得到一个时间轴划分
%说明：使曲线与起止点重合
% k：阶数
% n：控制点数

function [ T ] = getT(n,k)
T(1:k)=0;
for i=k+1:n
    T(i)=T(i-1)+1;
end
T(n+1:n+k)=T(n)+1;
end

