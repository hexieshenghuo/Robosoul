%% ����������
% Range����������ķ�Χ��[minX maxX minY maxY]
% d�����
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

