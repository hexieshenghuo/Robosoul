%% 设置并得到一个定时器
%% 
%% 
function [T] = getTimer(varargin)
   T=timer;
   if nargin>0
       T.Period = varargin{1};
   end
   if nargin>1
       T.ExecutionMode = varargin{2};
   else
       T.ExecutionMode = 'fixedRate';
   end
      
   if nargin>3
       set(T,'TimerFcn', {varargin{3},varargin{4}});
   end
   
   if nargin>5
       set(T,'StartFcn', {varargin{5},varargin{6}});
   end
   if nargin>7
       set(T, 'StopFcn',  {varargin{7},varargin{8}});
   end
end