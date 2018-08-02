%% 计算RBF网络的单点误差函数
%% 说明
% rbf: RBF神经网络
% x：输入
% yt：RBF期望的输出
% e:输出向量y与期望yt误差函数 e= (y -yt);
% f:输出误差函数 f= 1/2 ||e||^2
% g:误差函数的梯度(列向量)：g=[dC ds dW];
% varargout{1}:g
function [ f ,varargout ] = rbfErrorFun(rbf,x,yt)

   [y,H]=yRBFnet(rbf,x);
   e=y-yt;
   v=norm(e);
   f=0.5*v^2;
   
   %% 计算e
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

