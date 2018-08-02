%% 旋转的指数矩阵与旋量矩阵
%% 《机器人操作的数学导论》P17 （2.14） 和 2.36
%% 当2个参数时计算2.14 当3个参数时计算2.36
% w: 旋转方向
% theta:角度
% varargin{1}:v 速度
function [ M ] = eMat( w,theta,varargin)
   sw=Sw(w);
   I=[1 0 0;0 1 0;0 0 1];
   if nargin<3
       normW=norm(w);
       if normW==1
           M=I + sw*sin(theta) + sw^2*(1-cos(theta));
       else
           M=I + sw/normW*sin(normW*theta) + sw^2/(normW*normW)*(1-cos(normW*theta));
       end
   else
       v=varargin{1};
       e=eMat(w,theta);
       p=(I-e)*(sw*v) + w*w'*v*theta;
       M=[e p;[0 0 0 1]];
   end
end

