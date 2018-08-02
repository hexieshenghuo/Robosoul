%% 开启摄像头与定时器
%% 说明
%%
function startCamera(Camera,Timer,TaskFunc)
   set(Timer,'TimerFcn', {TaskFunc, Camera});
   start(Camera);
   start(Timer);
end