%% 获得一个Box的点集合通过这个点集合可以画出一个Box
%% 说明
% Box的重心为原点[0, 0, 0]
% Offset为偏移量 4×1列向量 如[1 2 3 0]' 最后一项必须为零
% varargin{1}:Offset;
% P 为4×24矩阵 每4列为一个面 一共6个面
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
%算长宽高的一半!
hL=Length/2;
hW=Width/2;
hH=Height/2;

One=[1 1 1 1];
%算偏移矩阵
offset=[Offset,Offset,Offset,Offset];

% plane   bottom
BottomX=[-hL hL hL -hL];
BottomY=[-hW -hW hW hW];
BottomZ=[-hH -hH -hH -hH];
P_Bottom=[BottomX;BottomY;BottomZ;One];
P_Bottom=P_Bottom+offset;%加偏移
P=[P P_Bottom];

% plane   top
TopX=[-hL hL hL -hL];
TopY=[-hW -hW hW hW];
TopZ=[hH hH hH hH];
P_Top=[TopX;TopY;TopZ;One];
P_Top=P_Top+offset;%加偏移
P=[P P_Top];

% plane3  front
FrontX=[-hL hL hL -hL];
FrontY=[-hW -hW -hW -hW];
FrontZ=[-hH -hH hH hH];
P_Front=[FrontX;FrontY;FrontZ;One];
P_Front=P_Front+offset;%加偏移
P=[P P_Front];

% plane4  back
BackX=[-hL hL hL -hL];
BackY=[hW hW hW hW];
BackZ=[-hH -hH hH hH];
P_Back=[BackX;BackY;BackZ;One];
P_Back=P_Back+offset;%加偏移
P=[P P_Back];

% plane5  left
LeftX=[-hL -hL -hL -hL];
LeftY=[hW -hW -hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%加偏移
P=[P P_Left];

% plane6  right
RightX=[hL hL hL hL];
RightY=[hW -hW -hW hW];
RightZ=[-hH -hH hH hH];
P_Right=[RightX;RightY;RightZ;One];
P_Right=P_Right+offset;%加偏移
P=[P P_Right];

Part.P=P;
end

