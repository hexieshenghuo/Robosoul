%% ����һ��㼯����ԭʼPatchͼ��
% I:ͼ��
% Points:�㼯
% width: Patch��
% r:��������������ʱ��Ҫԭʼ�任��ͼ��һЩ��
% SourcePatchSet:ԭʼPatch�� ����Ϊcell
%����SourcePatchSet{j}��ŵ�j��Patch
%%
function [ SourcePatchSet ] = getSourcePatchSet(I,Points,width,r)
M=length(Points);
SourcePatchSet=cell(M,1);
for j=1:M
    SourcePatchSet{j}=getSourcePatch(I,Points(:,j),width,r);
end
end

