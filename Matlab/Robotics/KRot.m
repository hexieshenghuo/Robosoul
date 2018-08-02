%% 任意轴变换通式
%% 4×4矩阵
% K:转轴方向向量 3维
% a:旋转的角度   数
function [M ] = KRot(K,a,varargin)
c=cos(a);
s=sin(a); 
v=1-c;
kx=K(1);
ky=K(2);
kz=K(3);
M=[kx*kx*v + c     ky*kx*v - kz*s  kz*kx*v + ky*s;
   kx*ky*v + kz*s  ky*ky*v + c     kz*ky*v - kx*s;
   kx*kz*v - ky*s  ky*kz*v + kx*s  kz*kz*v + c;
   0               0               0];
M=[M [0 0 0 1].'];
if nargin>2
    M=MR(M);
end
end

