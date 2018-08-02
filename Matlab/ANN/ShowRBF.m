function [y] = ShowRBF(varargin)
   s=1;
   range=10;
   if nargin>0
       len=length(varargin);
       s=varargin{1};
       if len>1
           range=varargin{2};
       end
   end
   x=-range:0.01:range;
   y=exp(-x.^2/(2*s^2));
   plot(x,y);
end

