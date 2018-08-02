%% 根据输入参数修改DH值
%% 
% DH: D-H参数顺序为 θ d a α
% Param:要更新的参数
% newDH：更新后的D-H参数
function [newDH] = updateDH(DH,Param,varargin)
   type='theta';
   newDH=DH;
   
   n=length(Param);
   
   if nargin>2
       type=varargin{1};
   end
   
   switch type
       case 'theta'
           newDH(1:n,1)=Param;
       case 'd'
           newDH(2:n,2)=Param;
       case 'a'
           newDH(3:n,3)=Param;
       case 'alpha'
           newDH(4:n,4)=Param;
   end
end