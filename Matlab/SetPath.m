%% ����RoboSoul·�� �ɸ���

%%
function SetPath(where)

if where=='l' %ʵ����̨ʽ��
    path(path,'F:\RoboSoul\Matlab\AerialManipulation');
    path(path,'F:\RoboSoul\Matlab\ImitationLearning\CGM');
    path(path,'F:\RoboSoul\Matlab\Vision');
    path(path,'F:\RoboSoul\Matlab\Optimization');
    path(path,'F:\RoboSoul\Matlab\AuxOper');
    path(path,'F:\RoboSoul\Matlab\GUI');
    path(path,'F:\RoboSoul\Matlab\ANN');
    path(path,'F:\RoboSoul\Matlab\RoboSim');
    path(path,'F:\RoboSoul\Matlab\Robotics');
    path(path,'F:\RoboSoul\Matlab\Control');
    path(path,'F:\RoboSoul\Matlab\RoboSim\Simulink');
end

if where=='h' %����ʼǱ�
    path(path,'G:\RoboSoul\Matlab\AerialManipulation');
    path(path,'G:\RoboSoul\Matlab\ImitationLearning\CGM');
    path(path,'G:\RoboSoul\Matlab\Vision');
    path(path,'G:\RoboSoul\Matlab\Optimization');
    path(path,'G:\RoboSoul\Matlab\AuxOper');
    path(path,'G:\RoboSoul\Matlab\GUI');
    path(path,'G:\RoboSoul\Matlab\ANN');
    path(path,'G:\RoboSoul\Matlab\RoboSim');
    path(path,'G:\RoboSoul\Matlab\Robotics');
    path(path,'G:\RoboSoul\Matlab\Control');
    path(path,'G:\RoboSoul\Matlab\RoboSim\Simulink');
end

savepath;
end

