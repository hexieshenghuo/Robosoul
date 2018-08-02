%% 计算基本旋转矩阵的导数形式 
%% 说明
%% 4×4矩阵
function [Res] = dR(theta,Type,varargin)
   s=sin(theta);
   c=cos(theta);
   switch Type
       case 'x'
           Res=[0  0   0  0;...
                0  -s  -c 0;...
                0  c   -s 0;...
                0  0   0  0];
       case 'y'
           Res=[-s  0  c  0;...
                0   0  0  0;...
                -c  0  -s 0;...
                0  0   0  0];
       case 'z'
           Res=[-s  -c  0 0;...
                c   -s  0 0;...
                0   0   0 0;...
                0   0   0 0];
   end
   
   if nargin>2
       if varargin{1}==3
           Res=MR(Res);
       end
   end
end

