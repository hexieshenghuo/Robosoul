%% 根据仿射矩阵T 生成仿射Patch (width×width)
% TMat maketform计算的仿射结构
% AffinePatch: 生成的仿射Patch

%%
function [ AffinePatch] = getAffinePatch(Patch,T,width)
   TMat=maketform('affine',T);
   AffinePatch=imtransform(Patch,TMat);
   s=size(AffinePatch);
   cx=floor(s(2)/2)+1;
   cy=floor(s(1)/2)+1;
   d=floor(width/2);
   AffinePatch=AffinePatch(cy-d:cy+d,cx-d:cx+d,:);
end

