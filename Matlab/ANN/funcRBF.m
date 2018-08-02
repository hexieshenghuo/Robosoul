%% 计算神经网络
% 参考：《机器学习导论》第12章 12.3径向基函数 （12.13） P184
% alpha：给X变量加权值
% c:中心
% s:接受域
% varargin{1}:alpha(α)
% varargout{1}=dC varargout{2}=ds 或者 varargout{1}=g,g=[dC;ds]
function [ y ,varargout] = funcRBF(x,c,s,varargin)
   alpha=1;
   if nargin>3
       alpha=varargin{1};
   end
   y=exp(-1*norm(alpha.*x-c)^2/(2*s^2));
   
   if nargout>1
       
       [ dC,ds ] = dH( y, x,c,s);
       % 输出G
       if narargout>2
           % 分体输出
           varargout{1}=dC;
           varargout{2}=ds;
       else
           % 整体输出
           varargout{1}=[dC;ds];
       end
       
   end
   
end