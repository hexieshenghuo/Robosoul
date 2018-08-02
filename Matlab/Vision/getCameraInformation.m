%% 得到当前摄像机信息 
%% 说明：
%% 
function [ CameraInfor ] = getCameraInformation()
   CameraInfor=imaqhwinfo('winvideo');
end