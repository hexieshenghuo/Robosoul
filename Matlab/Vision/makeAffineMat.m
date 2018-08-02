%% ���ɷ������
% �ο�: [1] ASIFT:A New Framework for Fully Affine Invariant Image Comparison
%       [2] Fast keypoint recognition using random ferns
% M��Ϊ3��3����
%%
function[ M ]= makeAffineMat(lamda,t,psi,phi)
T=[t 0 0;0 1 0;0 0 1];
M=lamda*rotMat(psi)*T*rotMat(phi);
M(3,3)=1;
end