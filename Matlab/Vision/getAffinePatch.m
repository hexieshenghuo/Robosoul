%% ���ݷ������T ���ɷ���Patch (width��width)
% TMat maketform����ķ���ṹ
% AffinePatch: ���ɵķ���Patch

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

