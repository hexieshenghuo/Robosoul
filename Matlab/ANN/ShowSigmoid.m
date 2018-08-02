%% 测试函数测试不同a下符号函数图形
%%
function ShowSigmoid(varargin)
   a=1;
   range=100;
   if nargin>0
       a=varargin{1};
   end
   if nargin>1
       range=varargin{2};
   end
   t=-range:0.1:range;
   y=1./(1 + exp(-a*t));
   plot(t,y);
   hold on;
end