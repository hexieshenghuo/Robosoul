%% ������ת���� 3��3
% theta:��ת�ĽǶ� ������
% M:�������

%%
function  M  = Rot( theta )
s=sin(theta);
c=cos(theta);
M=[c -s 0;s c 0;0 0 1];
end

