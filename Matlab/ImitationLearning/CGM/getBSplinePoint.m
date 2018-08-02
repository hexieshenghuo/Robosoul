%% ���ݲ�������B-Spline����ĳһ��
%% ˵�� 
% t:BSpline�������
% P�����Ƶ�
% T���ָ����
% k������
% N: P������ �����Ƶ���
function [ CurvePoint ] = getBSplinePoint(t,P,T,k,N,Dim)
   CurvePoint=zeros(Dim,1);
   for i=1:N
       CurvePoint=CurvePoint+P(:,i).*B(t,i,k,T);
   end
end

