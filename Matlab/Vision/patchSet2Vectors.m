%% 将Patch数据集合（例如AffinePatchSet）转为向量集合（DataVectors）数据形式为二维cell
%% 每一个Cell为一个矩阵，即一个Patch 
%% 将每个的cell的Patch变为Vector
% imData：比如AffinePatchSet
% DataVectors: cell集合 每个cell是一个vector
%% 只支持灰度图！
function [DataVectors,varargout] = patchSet2Vectors(PatchSet,p2vParam,varargin)
   width=p2vParam.width;
   Type=p2vParam.Type;
   [N,M]=size(PatchSet);%N-i M-j
   DataVectors=cell(N,M);
   D=0;
   for i=1:N
       for j=1:M
           Patch=PatchSet{i,j};
           Size=size(Patch);%M的大小
           dim=1;
           for t=1:length(Size) %为了兼容1维矩阵和三维矩阵
               dim=dim*Size(t);
           end
           [vector,D]=patch2Vector(Patch,width,Type);%Patch此时转为Vector
           DataVectors{i,j}=vector;
       end
   end
   varargout{1}=D;% 向量维数
end

