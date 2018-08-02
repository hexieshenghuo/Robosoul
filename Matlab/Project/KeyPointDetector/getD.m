%% 根据width和Type计算D
%% 说明
%%
function [D] = getD(width,Type)
   D=0;
   switch Type
    case 'c' %圆域
        d=floor(width/2);
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %判断是否在圆内
                    D=D+1;
                end
            end
        end
    case 'r' %取正方形
        D=width^2;
   end

end

