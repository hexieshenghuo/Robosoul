%% �õ�һ��t������ ��[t-range,t+range]�ڵ�������T
% T��t�Ữ��
% dt�����
% res�����ɵ�t����
% range����Χ
function [res] = getLocalt(T,dt,t,range )
res=max(0,t-range):dt:min(T(length(T)),t+range);
end

