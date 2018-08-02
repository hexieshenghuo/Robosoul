%% ����Բ���ĵ�!
%%
% OffsetΪƫ���������� ��[1 2 3 0]' ���һ�����Ϊ��
% P.cylinder��P.bottom��P.top��Ϊ4��N����
% varargin{1}: Offset
% N:Բ�����߾�������
% PΪ�ṹ��
function [P] = GetCylinder(R,Height,N,varargin)

Offset=[0;0;0;0];

if nargin>3
    Offset=varargin{1};% 
end

%Բ��Ͳ
[x,y,z]=cylinder(R,N);
z=z*Height;
z=z-Height/2;

x=reshape(x,1,length(x)*2);
y=reshape(y,1,length(y)*2);
z=reshape(z,1,length(z)*2);

P.Cylinder=[x;y;z;ones(1,length(x))];

theta=0:pi*2/N:pi*2;
%��Բ
topX=cos(theta)*R;
topY=sin(theta)*R;
topZ=ones(1,length(topX))*Height/2;
P.Top=[topX;topY;topZ;ones(1,length(topX))];
%��Բ
bottomX=cos(theta)*R;
bottomY=sin(theta)*R;
bottomZ=ones(1,length(topX))*Height/-2;
P.Bottom=[bottomX;bottomY;bottomZ;ones(1,length(bottomX))];

offset=repmat(Offset,1,length(P.Cylinder));
P.Cylinder=P.Cylinder+offset;

offset=repmat(Offset,1,length(P.Bottom));
P.Bottom=P.Bottom+offset;

offset=repmat(Offset,1,length(P.Top));
P.Top=P.Top+offset;

end