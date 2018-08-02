%% 从一个摄像机对象获得图像
%% 说明
% vargout{1}:getsnapshot的metedata
%%
function [ Image] = getImageFromCamera(Camera)
   [Image]=getsnapshot(Camera);
end