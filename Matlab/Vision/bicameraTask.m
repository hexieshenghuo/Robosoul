%% ����˫Ŀ����ͷ��ʱ������Ӧ����
%% ˵����

%%
function bicameraTask(hObject,eventdata, varargin)
   BiCamera=varargin{1};
   Image=getImageFromBiCamera(BiCamera);
   figure(1);
   imshow(Image);
   disp(size(Image));
end
