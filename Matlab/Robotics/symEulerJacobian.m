%% 用符号运算计算欧拉角与角速度之间的Jacobian矩阵
%% 注意符号的顺序无论是 如果是xyz 那么三个角度依次是 x、y、z的转角，如果
%% 是zyx 那么依次是 z、y、x的转角 但是往往很多资料中仍以x y z的顺序表达
% EulerAnler :3×1 欧拉角向量 符号变量
% EulerType: 欧拉角类型 'xyz' 'zyx' 'zyz'等
% CoordType: 相对坐标系类型：'B'or'b' 刚体自身坐标系 'W'or'w'世界惯性坐标系
% varargin{1}:符号变量(也可以是数值变量)[a b r].',用于替换e1 e2 e3的欧拉角符号

function [ J ] = symEulerJacobian( EulerType ,CoordType,varargin )
   
   E=sym('e',[3 1]); % 欧拉角符号向量
   dE=sym('de',[3 1]);
   
   R=EulerRotMat(E,EulerType);
   
   vR=reshape(R,9,1);% 3×3 R->9×1向量
   dR=jacobian(vR,E)*dE;
   dR=reshape(dR,3,3);

   if ( (CoordType=='B')||(CoordType=='b') )
       % 刚体自身坐标系处理 body frame
       Sw=R.'*dR;
   else 
       % 世界惯性坐标系处理
       Sw=dR*R.';
   end
   Sw=simplify(Sw);
   %
   F=[-Sw(2,3);Sw(1,3);-Sw(1,2)];
   J=jacobian(F,dE);
   
   % 用给定符号替换
   if nargin>2
       Euler=varargin{1};    
       J=subs(J,E,Euler);
%        J=subs(J,[E(1),E(2),E(3)],[Euler(1),Euler(2),Euler(3)]);
%        J=subs(J,E(2),);
%        J=subs(J,E(3),);
   end
   
end

