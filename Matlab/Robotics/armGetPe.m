%% �����е��ĩ��ִ��������ϵ�����һ������ϵ��ԭ�㵽������ϵ��λ��
%% ˵��

function [ Pe ] = armGetPe( arm )
   T=eye(4);
   
   for i=1:arm.LinkNum
       A=arm.Link(i).Aconst*arm.Link(i).Avar;
       T=T*A;
   end
   Pe=Vp(T); 
end