%% sigmoid�����ļ�����
%�ο��� ���İ桶������ԭ�� ������ ��4.32�� P118
% y sigmod�ĺ���ֵ
%%
function [d] = dSigmoid_y(y,a)
d=a*y.*(1-y);
end