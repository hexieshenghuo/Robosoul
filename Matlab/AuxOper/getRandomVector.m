%% ����һ����ָ����Χ�ڵ������������
%% ˵��
% Range��ȡֵ��Χ ����[1 9];
% N��
function [ RandomVector ,varargout] = getRandomVector( Range,N,varargin)
   
   M=1;
   if nargin>2
       M=varargin{1};
   end
   RandomVector=sort(randi(Range,N,M));
end