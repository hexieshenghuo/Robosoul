%------生成用于变换的三维Fast点形式如：[x y 1]
% N---只可以取9 10 11 12
function [Keypoints]=getFastKeypoints(I,N,thres,radius)
sizeI=size(I);
im=double(I(radius+1:sizeI(1)-radius,radius+1:sizeI(2)-radius));
switch N
    case 9
        FC=fast_corner_detect_9(im,thres);
    case 10
        FC=fast_corner_detect_10(im,thres);
    case 11
        FC=fast_corner_detect_11(im,thres);
    case 12
        FC=fast_corner_detect_12(im,thres);
end
FC=FC+radius;
%加一维!
Keypoints=[FC ones(length(FC),1)];

end