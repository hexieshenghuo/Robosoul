%% ��ÿ��cell��vector��������datavectorתΪһ������ľ���
%% ˵��
%%
%%
%%
function [Mat] = dataVectors2Mat(DataVectors)
   [N,M]=size(DataVectors);
   Dim=length(DataVectors{1,1});
   Mat=zeros(Dim,N*M);
   k=1;
   for i=1:N
       for j=1:M
           Mat(:,k)=DataVectors{i,j};
           k=k+1;
       end
   end
end