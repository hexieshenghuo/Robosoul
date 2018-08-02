function [ newArmModel ] = UpdateArmModel(DH,varargin)
   if nargin>1
       P=varargin{1};
   else
       P=[0 0 0 1]';
   end
   newArmModel=GetArmModel(DH,P);
end

