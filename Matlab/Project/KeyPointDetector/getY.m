%% ���� ����DataVector��Ӧ��Yij����
%% %% ���ڲ��Ժ��� ������ѧϰ���ݵ�yֵ
% DataVectors:����
% Param���������
%% 
function [Y] = getY(DataVectors,NetParam)
   [N,M]=size(DataVectors);
   Y=zeros(N,M);
   for i=1:N
       for j=1:M
           Y(i,j)=keypointDetector(DataVectors{i,j},NetParam,'sgn');
       end
   end
end