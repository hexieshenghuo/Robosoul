%% ��˫Ŀ����ͷ
%% ˵��
% CameraIDL:������ͷID
% CameraIDR:������ͷID
% varargin{1}:�������ʽ

%%
function [BiCamera] = openBiCamera(CameraIDL,CameraIDR,varargin)
   if nargin>2
      BiCamera.CameraL=openCamera(CameraIDL,varargin{1});
      BiCamera.CameraR=openCamera(CameraIDR,varargin{1});
   else
      BiCamera.CameraL=openCamera(CameraIDL);
      BiCamera.CameraR=openCamera(CameraIDR);
   end
end