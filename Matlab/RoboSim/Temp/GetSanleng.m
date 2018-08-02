%% 获得一个Box的点集合通过这个点集合可以画出一个棱柱
%% 说明
% Box的重心为原点[0, 0, 0]
% Offset为偏移量列向量 如[1 2 3 0]' 最后一项必须为零
% varargin{1}:Offset;
% P 为4×24矩阵 每4列为一个面 一共5个面
%% 
function [P] = GetSanleng(Length,Width,Height,varargin)

   Offset=[0 0 0 0]';
   if nargin>3
       Offset=varargin{1};
   end

P=[];
%算长宽高的一半!
hL=Length/2;
hW=Width/2;
hH=Height/2;%z

One=[1 1 1 1];
%算偏移矩阵
offset=[Offset,Offset,Offset,Offset];

% plane   bottom1,2,3,4
%BottomX=[-hL hL hL -hL];
%BottomY=[-hW -hW hW hW];
%BottomZ=[-hH -hH -hH -hH];
BottomX=[-hL hL hL -hL];
BottomY=[-hW -hW hW hW];
BottomZ=[-hH -hH -hH -hH];
P_Bottom=[BottomX;BottomY;BottomZ;One];
P_Bottom=P_Bottom+offset;%加偏移
P=[P P_Bottom];

% ront侧面1,2,5,5  由于是三角形，并且必须是四维的，所以最后一个点重复
FrontX=[-hL hL -hL -hL];
FrontY=[-hW -hW -hW -hW];
FrontZ=[-hH -hH hH hH];
P_Front=[FrontX;FrontY;FrontZ;One];
P_Front=P_Front+offset;%加偏移
P=[P P_Front];

% 侧面2  2,3,6,5
BackX=[hL hL -hL -hL];
BackY=[-hW hW hW -hW];
BackZ=[-hH -hH hH hH];
P_Back=[BackX;BackY;BackZ;One];
P_Back=P_Back+offset;%加偏移
P=[P P_Back];

% 侧面3，4,6,6
LeftX=[hL -hL -hL -hL];
LeftY=[hW hW hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%加偏移
P=[P P_Left];
% 侧面 侧面   4,1,5,6
LeftX=[-hL -hL -hL -hL];
LeftY=[hW -hW -hW hW];
LeftZ=[-hH -hH hH hH];
P_Left=[LeftX;LeftY;LeftZ;One];
P_Left=P_Left+offset;%加偏移
P=[P P_Left];

end