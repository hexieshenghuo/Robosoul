%% 根据一组点集生成原始Patch图像集
% I:图像
% Points:点集
% width: Patch宽
% r:余量比例（仿射时需要原始变换的图大一些）
% SourcePatchSet:原始Patch集 类型为cell
%其中SourcePatchSet{j}存放第j个Patch
%%
function [ SourcePatchSet ] = getSourcePatchSet(I,Points,width,r)
M=length(Points);
SourcePatchSet=cell(M,1);
for j=1:M
    SourcePatchSet{j}=getSourcePatch(I,Points(:,j),width,r);
end
end

