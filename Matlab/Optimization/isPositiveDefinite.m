%% �жϾ����Ƿ�����
%% ˵��
% res��1Ϊ���� 0Ϊ�Ǹ���
%%
function [ res ] = isPositiveDefinite( Mat )
[R,p]=chol(Mat);
res=(p==0);
end

