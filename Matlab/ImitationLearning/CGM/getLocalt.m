%% 得到一段t轴数据 在[t-range,t+range]内但不超过T
% T：t轴划分
% dt：间隔
% res：生成的t向量
% range：范围
function [res] = getLocalt(T,dt,t,range )
res=max(0,t-range):dt:min(T(length(T)),t+range);
end

