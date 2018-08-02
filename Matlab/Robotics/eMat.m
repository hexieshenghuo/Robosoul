%% ��ת��ָ����������������
%% �������˲�������ѧ���ۡ�P17 ��2.14�� �� 2.36
%% ��2������ʱ����2.14 ��3������ʱ����2.36
% w: ��ת����
% theta:�Ƕ�
% varargin{1}:v �ٶ�
function [ M ] = eMat( w,theta,varargin)
   sw=Sw(w);
   I=[1 0 0;0 1 0;0 0 1];
   if nargin<3
       normW=norm(w);
       if normW==1
           M=I + sw*sin(theta) + sw^2*(1-cos(theta));
       else
           M=I + sw/normW*sin(normW*theta) + sw^2/(normW*normW)*(1-cos(normW*theta));
       end
   else
       v=varargin{1};
       e=eMat(w,theta);
       p=(I-e)*(sw*v) + w*w'*v*theta;
       M=[e p;[0 0 0 1]];
   end
end

