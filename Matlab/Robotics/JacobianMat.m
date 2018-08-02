%% ���ݵ�ǰ�ǶȦ�i��Ai���㵱ǰJacobian����
%% ���㷨����֧��AΪDH�Ҿ�Ϊת���ؽ��㷨���ɵ�
%% �ο�����������ѧ���ۡ�������ϵͳ��Ӧ�á�
% A:i��i-1����ϵ�ı任����

function [ J ] = JacobianMat(A)
    N=length(A);
    n=N;
    T=cell(1,N);
    T{n}=A{n};
    % ���� iTn
    n=n-1;
    while(n>0)
        T{n}=A{n}*T{n+1};
        n=n-1;
    end
    %����Ji
    J=zeros(6,N);
    for i=1:N
       n= T{i}(1:3,1);
       o= T{i}(1:3,2);
       a= T{i}(1:3,3);
       p= T{i}(1:3,4);
       
       temp=cross(p,n);
       J(1,i)=temp(3);
       
       temp=cross(p,o);
       J(2,i)=temp(3);
       
       temp=cross(p,a);
       J(3,i)=temp(3);
       
       J(4:6,i)=(T{i}(3,1:3))';
    end
end