%% ����һ���и��嶯��ѧ���Ե�3Dģ��
%% ����Demo_1����
function [ Model ] = getModel()
   Model.J=50;       % ת������
   Model.k=0.00258;       % ������ϵ��
   Model.r=15;       % ����
   
   Model.Angle=60*pi/180;  %˳ʱ��Ϊ��������
   Model.Omiga=0;    %���ٶ�
   Model.dOmiga=0;   %�ǽ��ٶ�!
   
   %
   Model.ThreeDModel=GetBox(20,6,6);
   Model.T=10;       %��������10ms
end
