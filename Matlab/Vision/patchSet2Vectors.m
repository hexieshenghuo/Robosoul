%% ��Patch���ݼ��ϣ�����AffinePatchSet��תΪ�������ϣ�DataVectors��������ʽΪ��άcell
%% ÿһ��CellΪһ�����󣬼�һ��Patch 
%% ��ÿ����cell��Patch��ΪVector
% imData������AffinePatchSet
% DataVectors: cell���� ÿ��cell��һ��vector
%% ֻ֧�ֻҶ�ͼ��
function [DataVectors,varargout] = patchSet2Vectors(PatchSet,p2vParam,varargin)
   width=p2vParam.width;
   Type=p2vParam.Type;
   [N,M]=size(PatchSet);%N-i M-j
   DataVectors=cell(N,M);
   D=0;
   for i=1:N
       for j=1:M
           Patch=PatchSet{i,j};
           Size=size(Patch);%M�Ĵ�С
           dim=1;
           for t=1:length(Size) %Ϊ�˼���1ά�������ά����
               dim=dim*Size(t);
           end
           [vector,D]=patch2Vector(Patch,width,Type);%Patch��ʱתΪVector
           DataVectors{i,j}=vector;
       end
   end
   varargout{1}=D;% ����ά��
end

