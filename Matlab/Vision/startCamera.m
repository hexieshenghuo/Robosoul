%% ��������ͷ�붨ʱ��
%% ˵��
%%
function startCamera(Camera,Timer,TaskFunc)
   set(Timer,'TimerFcn', {TaskFunc, Camera});
   start(Camera);
   start(Timer);
end