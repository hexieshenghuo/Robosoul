%% ����RBF����ĵ�������
%% ˵��
% rbf: RBF������
% x������
% yt��RBF���������
% e:�������y������yt���� e= (y -yt);
% f:������� f= 1/2 ||e||^2
% g:�������ݶ�(������)��g=[dC ds dW];
% varargout{1}:g
function [ f ,varargout ] = rbfErrorFun(rbf,x,yt)

   [y,H]=yRBFnet(rbf,x);
   e=y-yt;
   v=norm(e);
   f=0.5*v^2;
   
   %% ����e
   if nargout>1
      %% dW
       E=repmat(e,rbf.numHid,1);
       dW=E.*H;
       dW0=e;
       
      %% dC & ds
       dC=zeros(rbf.dimX,rbf.numHid);
       dS=zeros(rbf.numHid,1);
       for i=1:rbf.numHid
           lamda=rbf.W(i,:)*e.';
           [dc,ds]=dH(H(i),x,rbf.C(:,i),rbf.S(i));
           dC(:,i)=dc*lamda;
           dS(i)=ds*lamda;
       end
       
       g=[reshape(dC,rbf.dimX*rbf.numHid,1);dS;reshape(dW,rbf.dimY*rbf.numHid,1);dW0];
       
       varargout{1}=g;
   end
   
end

