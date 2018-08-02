%% 从双目摄像机获取图像
%% 说明：
% BiCamera: 双目摄像机对象句柄
% Image：输出双目图像
% varargout{1}:输出左图像
% varargout{2}:输出右图像
%%
function [ Image,varargout] = getImageFromBiCamera(BiCamera )
   ImageL=getImageFromCamera(BiCamera.CameraL);
   ImageR=getImageFromCamera(BiCamera.CameraR);
   
   Image=[ImageL ImageR];
   if nargout>1
       varargout{1}=ImageL;
       varargout{2}=ImageR;
   end
end

