%% 将Patch转成向量
%% 只支持灰度图像
% Type：转换方式 ‘c’ 为取圆域 ‘r’ 取正常的正方形

%%
function [X,varargout] = patch2Vector(Patch,width,Type)
X=[];
d=floor(width/2);
switch Type
    case 'c' %取圆域
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %判断是否在圆内
                    X=[X;Patch(y,x)];
                end
            end
        end
    case 'r' %取正方形
        X=reshape(Patch,width*width,1);
end
X=double(X);
varargout{1}=length(X);% D:Vector维数
end
