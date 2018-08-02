%% ����ת����R����ȼ۵���������w���
%% �ο���������ѧ����ѧ���ۡ� P18 ��2.17����2.18��ʽ
% R��3��3��ת����
% w:ת������
% theta: ת�ǣ��ȣ�

function [ w, theta] = R2KRotParam( R )
   
   theta=acos( (trace(R)-1)/2 );
   
   theta=min(pi*2-theta,theta);
   w=[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)]/(2*sin(theta));
 
end