%% ���������
% T��t�Ữ��
% dt�����
% res�����ɵ�t����
%����T=[0,1,2,3,4,5] dt=0.5, �� res=[0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5]
function [res] = gent(T, dt )

theta=0.0000001;
P_end=T(length(T))-theta;%��ֹ��
res=0:dt:P_end;
if P_end-res(length(res))>theta
    res=[res P_end];
end
    
%res=res(1:length(res)-1);
end