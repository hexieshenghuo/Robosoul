%% 根据amModelScript.m的D-H参数计算的关节速度与末端相
%% 对飞机平台坐标系的Jacobian矩阵
%% 说明
%
function [ J,varargout ] = Je2q( theta, L )

   theta1=theta(1);
   theta2=theta(2);
   theta3=theta(3);
   theta4=theta(4);
   
   L1=L(1);
   L2=L(2);
   L3=L(3);
   L4=L(4);
   L5=L(5);
   
   
   J1=[ L3*sin(theta1 + theta2)*sin(theta3) - L1*sin(theta1) - L2*sin(theta1 + theta2) + sin(theta1 + theta2)*sin(theta3)*(L4 + L5),  sin(theta1 + theta2)*(L3*sin(theta3) - L2 + L4*sin(theta3) + L5*sin(theta3)), -cos(theta1 + theta2)*cos(theta3)*(L3 + L4 + L5),                                                                 0];
   J2=[ L2*cos(theta1 + theta2) + L1*cos(theta1) - L3*cos(theta1 + theta2)*sin(theta3) - cos(theta1 + theta2)*sin(theta3)*(L4 + L5), -cos(theta1 + theta2)*(L3*sin(theta3) - L2 + L4*sin(theta3) + L5*sin(theta3)), -sin(theta1 + theta2)*cos(theta3)*(L3 + L4 + L5),                                                                 0];
   J3=[                                                                                                                           0,                                                                             0,                       sin(theta3)*(L3 + L4 + L5),                                                                 0];
   J4=[                                                                                                                           0,                                                                             0,                            -sin(theta1 + theta2), sin(theta1 + theta2 - theta3)/2 - sin(theta1 + theta2 + theta3)/2];
   J5=[                                                                                                                           0,                                                                             0,                             cos(theta1 + theta2), cos(theta1 + theta2 + theta3)/2 - cos(theta1 + theta2 - theta3)/2];
   J6=[                                                                                                                           1,                                                                             1,                                                0,                                                      -cos(theta3)];

   J=[J1;J2;J3;J4;J5;J6];
   if nargout>1 % Jv
       varargout{1}=J(1:3,:);
   end
   if nargout>2 % Jw
       varargout{2}=J(4:6,:);
   end
end