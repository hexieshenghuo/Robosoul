%% �ж���ֹ����
%% ˵��
% res��1Ϊ������ֹ���� 0Ϊ��������ֹ����
% g:�ݶ�ֵ
% Thres����ֵ
%%
function [res] = isStop(g,Thres)
res=(norm(g)<=Thres);
end