%% S ���ź��� ������logistic����
% alpha: ���� ���Ʒ��ź����¶�

%%
function [y] = sigmoid(x,alpha)
    y=1./(1+exp(-alpha*x));
end