%% ��˫Ŀ�������ȡͼ��
%% ˵����
% BiCamera: ˫Ŀ�����������
% Image�����˫Ŀͼ��
% varargout{1}:�����ͼ��
% varargout{2}:�����ͼ��
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

