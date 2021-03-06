%m272.m             用Gauss-Seidel迭代运算
clear all;
close all;

%---(1)一例
R=[1 1 1 1 0 0 0;
    0 1 1 1 1 0 0;
    0 0 1 1 1 1 0;
    0 0 0 1 1 1 1]
C=R*R'
%----收敛性判别1(无碰撞)
 HG=tril(C)       %HG=H+G
 Z=C-HG
 F=-inv(HG)*Z
q=eig(F)          %求F的特征根

%----(2)两例
R1=[1 1 1 1 0 0 0;
    0 1 1 1 1 0 0;
    0 0 1 1 1 1 0;
    1 0 0 1 1 1 0]
C1=R1*R1'
%---收敛性判别2(有碰撞)
 H1G1=tril(C1)     %H1G1=H1+G1
 Z1=C1-H1G1
 F1=-inv(H1G1)*Z1
q1=eig(F1)        %求F1的特征根 

R2=[1 1 1 1 0 0 0;
    1 1 1 1 0 0 0;
    0 0 1 1 1 1 0;
    0 1 0 1 1 0 1]
C2=R2*R2'
%----收敛性判别2(有碰撞)
 H2G2=tril(C2)     %H2G2=H2+G2
 Z2=C2-H2G2
 F2=-inv(H2G2)*Z2
q2=eig(F2)        %求F2的特征根 
