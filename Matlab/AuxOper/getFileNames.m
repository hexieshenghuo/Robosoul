%% �õ��ƶ��ļ����������ƶ������ļ�
%% ˵��
% Dir���ļ���·��
% Postfix���ļ���׺
% �÷��磺 FileName=getFileNames('G:/RoboSoul/Vision/Matlab','m');
% ��  FileName=getFileNames('../../Vision/Matlab','m');
%%
function [ FileNames ] = getFileNames(Dir,Postfix)
   dirOutput=dir([Dir '/*.' Postfix]);
   FileNames={dirOutput.name}';% ����﷨������
end