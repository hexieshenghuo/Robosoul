%% 生成一个在指定范围内的升序随机向量
%% 说明
% Range：取值范围 比如[1 9];
% N：
function [ RandomVector ,varargout] = getRandomVector( Range,N,varargin)
   
   M=1;
   if nargin>2
       M=varargin{1};
   end
   RandomVector=sort(randi(Range,N,M));
end