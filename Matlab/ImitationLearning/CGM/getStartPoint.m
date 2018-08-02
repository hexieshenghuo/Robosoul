%% 初始化控制点
%% 说明
% Y: 待拟合的目标曲线
% N: 控制点数
% varargin：为键值对形式
function [Points] = getStartPoint(Y,N,varargin)
 
   [Dim,M]=size(Y);
   Points=zeros(Dim,N);
   Points(:,1)=Y(:,1);
   Points(:,N)=Y(:,M);
   
   if nargin>2
       N=length(varargin);
       for i=1:2:N
           switch varargin{i}
               case 'method'
                   switch varargin{i+1}
                       case 'OnYmean' %在Y上平均采样缩为初始点
                           for i=2:N-1
                               Points(:,i)=Y(round(M/(N-1))*i);
                           end
                       case 'OnStart' % 全部取起点
                           for i=2:N-1
                               Points(:,i)=Y(:,1);
                           end
                   end
           end
       end 
   else % 起止点连线均匀采样
       DP=Points(:,N)-Points(:,1);
       for i=2:N-1
           Points(:,i)=Points(:,1)+DP/(N-1)*(i-1);
       end
   end
end

