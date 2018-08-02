%% 根据仿射矩阵集合 生成原始Patch的仿射变换Patch集合 (width×width)
% TSet:变换矩阵集合 类型为Cell
% SourcePatchSet：原始Patch集合
% AffinePatchSet: 生成的仿射Patch集合

function [ AffinePatchSet] = getAffinePatchSet(SourcePatchSet,TSet,width)
   N=length(TSet);          %放射变换数 i
   M=length(SourcePatchSet);%原始Patch个数j
   AffinePatchSet=cell(N,M);
   for j=1:M
       for i=1:N
           patch = getAffinePatch(SourcePatchSet{j},TSet{i},width);%临时Patch
           AffinePatchSet{i,j}=patch;
       end
   end
end

