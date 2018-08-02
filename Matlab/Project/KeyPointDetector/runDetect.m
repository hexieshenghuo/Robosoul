%% ���ü�������ͼ��������
%% ˵��
% im:�����ͼ��Ϊ��ͨ��ͼ��
% NetParam�����������
% Step����ⲽ��
%%
function [Keypoints,varargout] = runDetect(I,NetParam,Step,varargin)
   width=NetParam.width;
   d=floor(width/2); %�뾶
   [Height,Wid]=size(I);
   Keypoints=[];
   N=0;
   for x=d+1:Step:Wid-d
       for y=d+1:Step:Height-d
           Point=[x;y];
           Patch=getPatch(I,Point,d);
           Patch=processPatch(Patch,NetParam);
           X=patch2Vector(Patch,width,NetParam.Type);
           y=keypointDetector(X,NetParam,NetParam.DetectMethod);
           N=N+1;
           if y==1
               Keypoints=[Keypoints Point];
           end
       end
   end
   varargout{1}=N;
end