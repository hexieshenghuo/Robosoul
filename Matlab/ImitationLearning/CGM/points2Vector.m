%% ��Points����ת��Ϊ����
%%
function [X] = points2Vector(Points)
   [Dim,N]=size(Points);
   X=reshape(Points,Dim*N,1);
end

