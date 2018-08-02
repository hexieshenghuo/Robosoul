%% ����������
% X���������������,��Ϊͼ��Patch���ݵ�������ʽ��n��1 ��nȡ����Patch��С��
% NetParam������������ṹ������
% Alpha��
% C��
% S��
% W��
% D:ά��
% H:������
% a: sigmoid�������ű���
% y����� 1��XΪ������ 0��X��Ϊ������
%%
function [y,varargout] = keypointDetector(X,NetParam,varargin)
% ��ȡ�������
   [ Alpha,C,S,W,H,D,a] = unpackNetParam( NetParam );
   P=zeros(H,1);
   for h=1:H
       p=funcRBF(X,C(:,h),S(h),Alpha(:,h));
       P(h)=p;
   end
   if nargin>2
      z=W.'*P;
      y=(z>=0);% 0-1ֵ
      varargout{1}=z;
   else
      y=sigmoid(W'*P,a);
   end
end