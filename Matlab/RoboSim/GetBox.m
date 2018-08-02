%% ���һ��Box�ĵ㼯��ͨ������㼯�Ͽ��Ի���һ��Box
%% ˵��
% Box������Ϊԭ��[0, 0, 0]
% OffsetΪƫ���� 4��1������ ��[1 2 3 0]' ���һ�����Ϊ��
% varargin{1}:Offset;
% P Ϊ4��24���� ÿ4��Ϊһ���� һ��6����
%% 
function [ Part ] = GetBox(Length,Width,Height,varargin)

   Offset=[0 0 0 0].';
   if nargin>3
       Offset=varargin{1};
       if length(Offset)<4
%            Offset(4)=0;
       end
   end

P=[];
%�㳤��ߵ�һ��!
hL=Length/2;
hW=Width/2;
hH=Height/2;

One=[1 1 1 1];
%��ƫ�ƾ���
offset=[Offset,Offset,Offset,Offset];

% plane   bottom
BottomX=[-hL hL hL -hL];
BottomY=[-hW -hW hW hW];
BottomZ=[-hH -hH -hH -hH];
P_Bottom=[BottomX;BottomY;BottomZ;One];
P_Bottom=P_Bottom+offset;%��ƫ��
P=[P P_Bottom];

% plane   top
TopX=[-hL hL hL -hL];
TopY=[-hW -hW hW hW];
TopZ=[hH hH hH hH];
P_Top=[TopX;TopY;TopZ;One];
P_Top=P_Top+offset;%��ƫ��
P=[P P_Top];

% plane3  front
FrontX=[-hL hL hL -hL];
FrontY=[-hW -hW -hW -hW];
FrontZ=[-hH -hH hH hH];
P_Front=[FrontX;FrontY;FrontZ;One];
P_Front=P_Front+offset;%��ƫ��
P=[P P_Front];

% plane4  back
BackX=[-hL hL hL -hL];
BackY=[hW hW hW hW];
BackZ=[-hH -hH hH hH];
P_Back=[BackX;BackY;BackZ;One];
P_Back=P_Back+offset;%��ƫ��
P=[P P_Back];

% plane5  left
LeftX=[-hL -hL -hL -hL];
LeftY=[hW -hW -hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%��ƫ��
P=[P P_Left];

% plane6  right
RightX=[hL hL hL hL];
RightY=[hW -hW -hW hW];
RightZ=[-hH -hH hH hH];
P_Right=[RightX;RightY;RightZ;One];
P_Right=P_Right+offset;%��ƫ��
P=[P P_Right];

Part.P=P;
end

