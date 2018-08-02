%% 公式推导
syms phi;   % Roll  X
syms theta; % Pitch Y
syms psi;   % Yaw   Z

Rx=Rot(phi,'x');
Ry=Rot(theta,'y');
Rz=Rot(psi,'z');

R=Rz*Ry*Rx;
disp(R);