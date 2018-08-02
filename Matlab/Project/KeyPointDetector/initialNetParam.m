%% ��ʼ������NetParam
%% ˵��
% Data����ʼ����������
% D������ά��
% H: �������
% a�����ź������Ų�����y=1/(1+exp(-aX))
%%
function [NetParam] = initialNetParam(DataVectors,D,H,a)
%
%    DataMat=dataVectors2Mat(DataVectors);
%��ʼ���������
   NetParam.Alpha=ones(D,H);%rand(D,H)-0.5;
   NetParam.S=ones(H,1)*10;
   NetParam.W=(rand(H,1)-0.5)*60;%zeros(H,1);%;
   %��K-Means�����ʼ��C
   
   %[inx,C]=kmeans(DataMat',H);
   %NetParam.C=C';
   NetParam.C=(rand(D,H)>=0.5);%rand(D,H);%
   NetParam.a=a;
   NetParam.D=D;
   NetParam.H=H;
end