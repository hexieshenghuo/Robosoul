%% ȡͼ���������Patch
%% ˵��: 1������Խ������ Խ���������ϲ���ú�������
% I:ͼ��
% Point�����ĵ�
% d���뾶
function [Patch,varargout] = getPatch(I,Point,d,varargin)
   x=Point(1);
   y=Point(2);
   Patch=I(y-d:y+d,x-d:x+d,:);
end