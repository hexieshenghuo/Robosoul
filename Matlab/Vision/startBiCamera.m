%% ����˫Ŀ����ͷ�붨ʱ��
%% ˵��
%%
function startBiCamera(BiCamera,Timer,TaskFunc)
   set(Timer,'TimerFcn', {TaskFunc, BiCamera});
   start(BiCamera.CameraL);
   start(BiCamera.CameraR);
   start(Timer);
end