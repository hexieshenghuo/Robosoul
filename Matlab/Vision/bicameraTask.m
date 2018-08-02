%% 用于双目摄像头定时器的相应函数
%% 说明：

%%
function bicameraTask(hObject,eventdata, varargin)
   BiCamera=varargin{1};
   Image=getImageFromBiCamera(BiCamera);
   figure(1);
   imshow(Image);
   disp(size(Image));
end
