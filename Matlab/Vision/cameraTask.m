%% 用于摄像头定时器的相应函数
%% 说明：

%%
function cameraTask(hObject,eventdata, varargin)
   Camera=varargin{1};
   Image=getsnapshot(Camera);
   figure(1);
   imshow(Image);
end