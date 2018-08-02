%% 计算一个一般形式的高斯核RBF函数的梯度
%% 说明
% g:梯度[dc ds];
% 
function [ g,varargout] = dRBF( x,c,s )

   f=funcRBF(x,c,s);
   
   dc=f*(x - c)/s^2
   ds=f*norm(x-c)^2/s^3;
   
   g=[dc;ds];
   
   if nargout>1
       varargout{1}=f;
   end
   
end