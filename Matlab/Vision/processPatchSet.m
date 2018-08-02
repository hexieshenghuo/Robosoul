%% 处理一个Patch集合
function [ outPatchSet] = processPatchSet(PatchSet,proParam)
   [N,M]=size(PatchSet);
   outPatchSet=cell(N,M);
   for i=1:N
       for j=1:M
           outPatch=processPatch(PatchSet{i,j},proParam);
           outPatchSet{i,j}=outPatch;
       end
   end
end

