%% ��λ������ ʹ����ģΪ1
function [nX,varargout] = Normalize(X)
   Mag=norm(X);
   nX=X/Mag;
   if nargout>1
       varargout{1}=Mag;
   end
end