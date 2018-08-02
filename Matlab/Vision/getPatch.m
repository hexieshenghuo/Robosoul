%% 取图像特征点的Patch
%% 说明: 1不考虑越界问题 越界问题由上层调用函数处理
% I:图像
% Point：中心点
% d：半径
function [Patch,varargout] = getPatch(I,Point,d,varargin)
   x=Point(1);
   y=Point(2);
   Patch=I(y-d:y+d,x-d:x+d,:);
end