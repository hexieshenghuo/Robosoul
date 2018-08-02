%% ���ݷ�����󼯺� ����ԭʼPatch�ķ���任Patch���� (width��width)
% TSet:�任���󼯺� ����ΪCell
% SourcePatchSet��ԭʼPatch����
% AffinePatchSet: ���ɵķ���Patch����

function [ AffinePatchSet] = getAffinePatchSet(SourcePatchSet,TSet,width)
   N=length(TSet);          %����任�� i
   M=length(SourcePatchSet);%ԭʼPatch����j
   AffinePatchSet=cell(N,M);
   for j=1:M
       for i=1:N
           patch = getAffinePatch(SourcePatchSet{j},TSet{i},width);%��ʱPatch
           AffinePatchSet{i,j}=patch;
       end
   end
end

