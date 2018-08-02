%% Sample5 双目摄像头读取、显示测试
%% 说明
%%
%%
function Tst
BiCamera= openBiCamera(1,2,'MJPG_1280x720');% 'MJPG_320x240'  
Timer=getTimer(0.1);
startBiCamera(BiCamera,Timer,@bicameraTask);

% Camera= openCamera(1,'MJPG_640x480');
% Timer=getTimer(0.01);
% startCamera(Camera,Timer,@cameraTask);
end