%% ���¸�������ϵ��R
%% Ŀǰ������xyzŷ����
%% 
function [ rm ] = rmR( rm )
   
   Rx=Rot(rm.Euler(1),'x',3);
   Ry=Rot(rm.Euler(2),'y',3);
   Rz=Rot(rm.Euler(3),'z',3);
   rm.R=Rx*Ry*Rz;
   
end