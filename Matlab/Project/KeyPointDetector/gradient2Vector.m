%% �����������ݶ�תΪ������ʽ
%%
function [ gVector ] = gradient2Vector(dAlpha,dC,dS,dW,D,H)
% Alpha
   vectorAlpha=reshape(dAlpha,D*H,1);
% C
   vectorC=reshape(dC,D*H,1);
% S
   %����
% W
   %����
%�洢
   gVector=[vectorAlpha;vectorC;dS;dW];
end