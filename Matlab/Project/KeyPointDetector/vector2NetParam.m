%% ��ѵ��������������ʽתΪParam�ṹ������NetParam
%  ˳��Ϊ��Alpha C S W
%% ����
% Alpha��D��H
% C��D��H
% S��H��1
% W��H��1
% D�������ά��
% H������ڵ����

%% ע��������ݶ���������ͬά�ȣ��� C �� df/dC ����D��H
%% ��˶����ݶȵ�ת��Ҳ�����øú���
%%
function [NetParam] = vector2NetParam(Vector,D,H,a)
   step=D*H; %�ֶεĲ���
% Alpha
   alpha=Vector(1:step);
   alpha=reshape(alpha,D,H);
% C
   c=Vector(step+1:2*step);
   c=reshape(c,D,H);
% S
   s=Vector(2*step+1:2*step+H);
% W
   w=Vector(2*step+H+1:2*step+2*H);
   NetParam.Alpha=alpha;
   NetParam.C=c;
   NetParam.S=s;
   NetParam.W=w;
   
   NetParam.D=D;
   NetParam.H=H;
   NetParam.a=a;
end