%% ���ݵ�ǰ��������amlģ�͵���λ�á���̬��صĲ���
%% ˵��
% varargin{1}: theta
% varargin{2}: Tup
function [ al ] = alUpdatePose( al, varargin)
   
   if nargin>1 % theta
       al.Theta=varargin{1};
   end
   
   if nargin>2 %Tup
       al.Tup=varargin{2};
   end

   % A
   al.Avar=Rot(al.Theta,'z');
   al.A=al.Aconst*al.Avar;
   
   % R
   al.R=MR(al.A);
   
   % T
   al.T=al.Tup*al.A;
   
   % 
   
end