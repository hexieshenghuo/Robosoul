%% ������������޸�DHֵ
%% 
% DH: D-H����˳��Ϊ �� d a ��
% Param:Ҫ���µĲ���
% newDH�����º��D-H����
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