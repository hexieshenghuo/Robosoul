%% ׷���������������ظ�������ģ��
%% ˵�������еĲ�����Ӧ��Ը�������ϵ
% f: ��
% r: ����
% t��ת��
function [ qm ] = qmAddDriver(qm, f,r,t,varargin )

   qm.rm.F=[qm.rm.F f];
   qm.rm.r=[qm.rm.r r];
   qm.rm.T=[qm.rm.T t];
   
end

