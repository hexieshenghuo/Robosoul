%% 根据欧拉角计算旋转矩阵
%% 注意符号的顺序无论是 如果是xyz 那么三个角度依次是 x、y、z的转角，如果
%% 是zyx 那么依次是 z、y、x的转角 但是往往很多资料中仍以x y z的顺序表达
% EulerAngles: 欧拉角默认列向量
% varargin{1}: 欧拉角类型 type
% R:旋转矩阵
function [ R ] = EulerRotMat( EulerAngles ,varargin )
   type='xyz';   %默认欧拉角类型
   if nargin>1
       type=varargin{1};
   end
   switch type
       case 'xyz'
           R=Rot(EulerAngles(1),'x')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'z');
       case 'zyx'
           R=Rot(EulerAngles(1),'z')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'x');
       case 'zyz'
           R=Rot(EulerAngles(1),'z')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'z');
       case 'xyx'
           R=Rot(EulerAngles(1),'x')*Rot(EulerAngles(2),'y')*Rot(EulerAngles(3),'x');
   end
   R=MR(R);
end

