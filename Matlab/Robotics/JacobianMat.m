%% 根据当前角度θi、Ai计算当前Jacobian矩阵
%% 该算法仅仅支持A为DH且均为转动关节算法生成的
%% 参考：《机器人学导论—分析、系统以应用》
% A:i与i-1坐标系的变换矩阵

function [ J ] = JacobianMat(A)
    N=length(A);
    n=N;
    T=cell(1,N);
    T{n}=A{n};
    % 计算 iTn
    n=n-1;
    while(n>0)
        T{n}=A{n}*T{n+1};
        n=n-1;
    end
    %计算Ji
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