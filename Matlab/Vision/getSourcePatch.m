%% 生成某点的原始Patch
% I:图像
% P:中心点
% width: Patch宽
% r:余量比例（仿射时需要原始变换的图大一些）
% Patch
%%
function [ Patch ] = getSourcePatch(I,P,width,r)
   d=floor(width/2);
   Patch=I(P(2)-d*r:P(2)+d*r,P(1)-d*r:P(1)+d*r,:);% P(1):X 列,P(2):Y 行 
end

