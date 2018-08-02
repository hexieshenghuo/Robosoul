%% 计算欧拉角导数和角速度之间的关系
%% 说明
%
%
%
function [Je] = EulerJacobian( Euler,EulerType, CoordType )
   if (CoordType=='B' || CoordType=='b')
       switch EulerType
           case 'xyz'
               Je=[ cos(Euler(1))*cos(Euler(3)), sin(Euler(3)),  0;...
                   -cos(Euler(2))*sin(Euler(3)), cos(Euler(3)),  0;...
                                  sin(Euler(2)),             0,  1];
       end
   else % 'W' 'w'
       switch EulerType
           case 'xyz'
               Je=[ 1,             0,               sin(Euler(2));...
                    0, cos(Euler(1)), -cos(Euler(2))*sin(Euler(1) );...
                    0, sin(Euler(1)),  cos(Euler(1))*cos(Euler(2) )];
       end
   end
end

