%% �����ٶȱ任�İ���任(adjoint transformation)
%% �������˲�������ѧ���ۡ�P34 ��2.57�� �� (2.58)
%% 
function [ M ] = Adg( R,p )
   M=[R Sw(p)*R;zeros(3) R];
end