%% ƽ�Ʊ任����
%%
% D��ΪΪ4��1ά�����������һ����������1��
function [ Mat ] = Trans(D)
   l=length(D);
   if l==3
       Mat=[[1 0 0;0 1 0;0 0 1] D;[0 0 0 1]];
   else
       Mat=[eye(3);[0 0 0]];
       Mat=[Mat D];
   end
   
   Mat(4,:)=[0 0 0 1];% Ϊ�˷�ʽD���һ����0�������
end