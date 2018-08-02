%% 将向量转成Patch
% Type：转换方式 ‘c’ 为取圆域 ‘r’ 取正常的正方形

%%
function [Patch] = vector2Patch(X,width,Type)
Patch=zeros(width,width);
d=floor(width/2);
n=1;
switch Type
    case 'c' %圆域
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %判断是否在圆内
                    Patch(y,x)=X(n);
                    n=n+1;
                end
            end
        end
    case 'r' %取正方形
        Patch=reshape(X,width,width);
end
end

