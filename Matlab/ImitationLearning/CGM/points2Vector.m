%% 将Points矩阵转换为向量
%%
function [X] = points2Vector(Points)
   [Dim,N]=size(Points);
   X=reshape(Points,Dim*N,1);
end

