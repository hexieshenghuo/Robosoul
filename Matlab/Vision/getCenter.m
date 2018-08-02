%% 辅助函数 计算一个区域的中心
% 区域宽度应为奇数
% width:横轴
% height：纵轴
% cx:横轴（列）
% cy:纵轴（行）
%%
function [cx,cy] = getCenter( width, height )
cx=ceil(width/2);
cy=ceil(height/2);
end

