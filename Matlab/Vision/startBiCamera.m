%% 开启双目摄像头与定时器
%% 说明
%%
function startBiCamera(BiCamera,Timer,TaskFunc)
   set(Timer,'TimerFcn', {TaskFunc, BiCamera});
   start(BiCamera.CameraL);
   start(BiCamera.CameraR);
   start(Timer);
end