%% ����RBF�������ֵ

function [ Y ,varargout] = yRBFnet( rbf, X,varargin )

   %% ����H
   H=zeros(rbf.numHid,1);
   
   for i=1:rbf.numHid
       H(i)=funcRBF(X,rbf.C(:,i),rbf.S(i));
   end
   Y=rbf.W.'*H + rbf.W0*rbf.l;
   
   if nargout>1
       varargout{1}=H;
   end
   
end