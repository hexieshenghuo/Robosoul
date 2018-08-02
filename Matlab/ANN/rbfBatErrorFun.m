%% �������ݵ�RBF����
%% ˵��
% X: ��������
% Y�������������
% E: ���������ۼ����
function [ E ,varargout ] = rbfBatErrorFun( rbf, X ,Yt)

   s=size(X);
   SampleNum=s(2);
   
   E=0;
   G=zeros(rbf.dimX*rbf.numHid+ rbf.numHid + rbf.numHid* rbf.dimY +rbf.dimY ,1);
   
   for i=1:SampleNum
       x=X(:,i);
       yt=Yt(:,i);
       if nargout>1
           [ e ,g ] = rbfErrorFun(rbf, x, yt );
           G=G+g;
       else
           e = rbfErrorFun(rbf, x, yt );
       end
       E=E+e;
   end
   
   %% ����ݶ�
   if nargout>1
       varargout{1}=G;
   end
   
end