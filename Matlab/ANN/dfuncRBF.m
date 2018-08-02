%% 计算RBF函数各个变量梯度
% dRBF_dx：x偏导
% dRBF_dc：c偏导
% dRBF_ds：s偏导
% g:整个的梯度
% y：exp(-norm(c - a.*x)^2/(2*s^2))实际就是funcRBF的y值
%% 
function [dRBF_dx,dRBF_dalpha,dRBF_dc,dRBF_ds] = dfuncRBF(x,c,s,a)
f=funcRBF(x,c,s,a);
temp=-f*(a.*x-c)./s^2;

dRBF_dx = a.*temp;
dRBF_dc = -temp ;
dRBF_ds = f*2*norm(a.*x-c)^2/s^3;
dRBF_dalpha = x.*temp;

% g=[dRBF_dx;dRBF_dc;dRBF_ds;dRBF_da];
end

