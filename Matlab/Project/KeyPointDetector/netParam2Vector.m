%% ��Param����Ҫѵ���ı���д��������ʽ ˳��Ϊ��Alpha C S W
%% ˵�� ����
% Alpha��D��H
% C��D��H
% S��H��1
% W��H��1
% D�������ά��
% H������ڵ����
% Vector��2��D+1��H��1ά����
%% ע��������ݶ���������ͬά�ȣ��� C �� df/dC ����D��H
%% ��˶����ݶȵ�ת��Ҳ�����øú���
%%
function [Vector] = netParam2Vector(NetParam)
% ת����
Alpha=NetParam.Alpha;
C=NetParam.C;
S=NetParam.S;
W=NetParam.W;
D=NetParam.D;
H=NetParam.H;

% Alpha
vectorAlpha=reshape(Alpha,D*H,1);
% C
vectorC=reshape(C,D*H,1);
% S
   %����
% W
   %����
%�洢
Vector=[vectorAlpha;vectorC;S;W];
end

