%% ����ĳ���ԭʼPatch
% I:ͼ��
% P:���ĵ�
% width: Patch��
% r:��������������ʱ��Ҫԭʼ�任��ͼ��һЩ��
% Patch
%%
function [ Patch ] = getSourcePatch(I,P,width,r)
   d=floor(width/2);
   Patch=I(P(2)-d*r:P(2)+d*r,P(1)-d*r:P(1)+d*r,:);% P(1):X ��,P(2):Y �� 
end

