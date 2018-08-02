%% ����D-H��������Ai ��Ti
%%
% A: ����ϵi���������ϵi-1�ı任����,������ʽΪcell 
% A{i}����һ���ؽھ���
% T: ����ϵi����ڻ����꣨����ϵ0���ı任����������ʽΪcell
% T{i}����һ���ؽڵ���������ϵ�ľ���
% DH��D-H���� ÿһ��Ϊһ��D-H����

function [A,T] = updateTrans( DH )
   [N,M]=size(DH);
   A=cell(N,1);% ����ϵi��i+1�ı任����
   T=cell(N,1);% ����ϵi��0�ı任����
   A{1}=DHTrans(DH(1,:));
   T{1}=A{1};
   for i=2:N
       A{i}= DHTrans(DH(i,:));
       T{i}=T{i-1}*A{i};
   end
end

