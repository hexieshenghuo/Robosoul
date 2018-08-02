%% 用于Demo_1程序
function [ newModel , varargout] = UpdateModel( model, param,varargin)
   newModel=model;
   k=model.k;
   if nargin>2
       w1=param;
       w2=varargin{1};
       F1=k*w1^2;
       M1=model.r*F1;   
       F2=k*w2^2;
       M2=model.r*F2;   
       SumM=M1-M2;
       newModel.dOmiga=-SumM/model.J; 
       newModel.Omiga=newModel.Omiga + newModel.dOmiga*newModel.T;
   else
       newModel.dOmiga=param-newModel.Omiga;
       newModel.Omiga=param;
   end
   newModel.Angle=newModel.Angle + newModel.Omiga*newModel.T;
   
   if nargout>1
       varargout{1}=newModel.Angle;%角度
   end
   if nargout>2
       varargout{2}=newModel.Omiga;
   end
   if nargout>3
       varargout{3}=newModel.dOmiga;
   end
end

