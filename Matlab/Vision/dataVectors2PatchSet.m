%% 将每个cell为一个向量的
function [PatchSet] = dataVectors2PatchSet(DataVectors,width,Type)
    [N,M]=size(DataVectors);
    PatchSet=cell(N,M);
    for i=1:N
        for j=1:M
            PatchSet{i,j}=vector2Patch(DataVectors{i,j},width,Type);
        end
    end
end