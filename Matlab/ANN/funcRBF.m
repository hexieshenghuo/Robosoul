%% ����������
% �ο���������ѧϰ���ۡ���12�� 12.3��������� ��12.13�� P184
% alpha����X������Ȩֵ
% c:����
% s:������
% varargin{1}:alpha(��)
% varargout{1}=dC varargout{2}=ds ���� varargout{1}=g,g=[dC;ds]
function [ y ,varargout] = funcRBF(x,c,s,varargin)
   alpha=1;
   if nargin>3
       alpha=varargin{1};
   end
   y=exp(-1*norm(alpha.*x-c)^2/(2*s^2));
   
   if nargout>1
       
       [ dC,ds ] = dH( y, x,c,s);
       % ���G
       if narargout>2
           % �������
           varargout{1}=dC;
           varargout{2}=ds;
       else
           % �������
           varargout{1}=[dC;ds];
       end
       
   end
   
end