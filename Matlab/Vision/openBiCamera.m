%% 打开双目摄像头
%% 说明
% CameraIDL:左摄像头ID
% CameraIDR:右摄像头ID
% varargin{1}:摄像机格式

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