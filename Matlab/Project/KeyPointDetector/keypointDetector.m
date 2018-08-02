%% 特征点检测器
% X：检测器网络输入,即为图像Patch数据的向量形式：n×1 （n取决于Patch大小）
% NetParam：神经网络参数结构包括：
% Alpha：
% C：
% S：
% W：
% D:维数
% H:隐层数
% a: sigmoid函数缩放比例
% y：结果 1：X为特征点 0：X不为特征点
%%
function [y,varargout] = keypointDetector(X,NetParam,varargin)
% 提取网络参数
   [ Alpha,C,S,W,H,D,a] = unpackNetParam( NetParam );
   P=zeros(H,1);
   for h=1:H
       p=funcRBF(X,C(:,h),S(h),Alpha(:,h));
       P(h)=p;
   end
   if nargin>2
      z=W.'*P;
      y=(z>=0);% 0-1值
      varargout{1}=z;
   else
      y=sigmoid(W'*P,a);
   end
end