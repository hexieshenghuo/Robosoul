%% ����һ��һ����ʽ�ĸ�˹��RBF�������ݶ�
%% ˵��
% g:�ݶ�[dc ds];
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