%% 采样点坐标
% Range：采样坐标的范围：[minX maxX minY maxY]
% d：间隔
%%
function [Points] = getSamplePoints(Range,d)
Points=[];
for x=Range(1):d:Range(2)
    for y=Range(3):d:Range(4)
        p=[x;y];
        Points=[Points p];
    end
end
end

