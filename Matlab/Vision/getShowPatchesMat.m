%% ����һ����ʾPatch���ϵľ���
%% ˵��
function [Mat] = getShowPatchesMat(Patches)
    [N,M]=size(Patches);
    
    Mat=[];
    
    for i=1:N
        m=[];
        for j=1:M
            m=[m Patches{i,j}];
        end
        Mat=[Mat;m];
    end
end

