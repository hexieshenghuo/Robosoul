%% �õ�һ��ʱ���Ữ��
%˵����ʹ��������ֹ���غ�
% k������
% n�����Ƶ���

function [ T ] = getT(n,k)
T(1:k)=0;
for i=k+1:n
    T(i)=T(i-1)+1;
end
T(n+1:n+k)=T(n)+1;
end

