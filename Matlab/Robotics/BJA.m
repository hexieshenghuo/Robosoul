%% ��������ϵ���ٶȵı任����BJA
%% �ο�����Robotics Toolbox Manual�� 3.1 Forward and inverse kinematics��
%% �ر��ǹ�ʽ��10��
%% 
% ATB������ϵB��Aϵ�ı任����
function [ J ] = BJA( ATB )
  
   T=ATB;   
   n=Vn(T);
   o=Vo(T);
   a=Va(T);
   p=Vp(T);
   
   R=MR(T)';
   
   p_n=cross(p,n);
   p_o=cross(p,o);
   p_a=cross(p,a);
   
   B=[p_n p_o p_a].';
   
   J=[R B;zeros(3) R];
end

