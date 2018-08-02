%% 利用检测器检测图像特征点
%% 说明
% im:待检测图像为单通道图像
% NetParam：检测器参数
% Step：检测步长
%%
function [Keypoints,varargout] = runDetect(I,NetParam,Step,varargin)
   width=NetParam.width;
   d=floor(width/2); %半径
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