%% ������ͷ
%% ˵��
% varargin{1}:��Ƶ���� ��С��ʽ�� �磺'MJPG_640x480'
%% 
function [ Camera,varargout] = openCamera(CameraID,varargin)
   if nargin<2
       Camera = videoinput('winvideo',CameraID);
   else
       Camera = videoinput('winvideo',CameraID,varargin{1});
   end
   set(Camera, 'FramesPerTrigger', 1);
   triggerconfig(Camera, 'manual');
end