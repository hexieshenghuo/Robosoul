%% ��������ͷ��ʱ������Ӧ����
%% ˵����

%%
function cameraTask(hObject,eventdata, varargin)
   Camera=varargin{1};
   Image=getsnapshot(Camera);
   figure(1);
   imshow(Image);
end