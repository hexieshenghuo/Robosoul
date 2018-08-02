%% 主测试程序
%% 创建一个旋翼机械臂3D模型

AM=getAMModel();
DrawComponent(AM.Component);
Scale=600;
SetShowState([-Scale,Scale,-Scale,Scale,-Scale,Scale]);