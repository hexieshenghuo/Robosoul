%% �����ת����(4��4)
% theta:��ת�ĽǶ�
% type:��ת�����X���Y���Z��
function [Mat] = Rot(theta,type,varargin)
c=cos(theta);
s=sin(theta);
switch type
    case 'x'
        Mat=[1 0 0 0;...
             0 c -1*s 0;...
             0 s c 0;... 
             0 0 0 1];
    case 'y'
        Mat=[c 0 s 0;...
             0 1 0 0;...
             -1*s 0 c 0;...
             0 0 0 1];
    case 'z'
        Mat=[c -1*s 0 0;...
             s c 0 0;...
             0 0 1 0;...
             0 0 0 1];
end
     if nargin>2
       if varargin{1}==3
           Mat=MR(Mat);
       end
     end
end

