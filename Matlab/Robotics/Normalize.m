%% 单位化向量 使向量模为1
function [nX,varargout] = Normalize(X)
   Mag=norm(X);
   nX=X/Mag;
   if nargout>1
       varargout{1}=Mag;
   end
end