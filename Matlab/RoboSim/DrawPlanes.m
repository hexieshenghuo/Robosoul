%�����ƽ�� Pÿ����Ϊһ��ƽ������
function [P] = DrawPlanes(P,Num,Colors)

for i=0:Num-1
    p=P(:,i*4+1:i*4+4);
    DrawPlane(p,Colors);
end
end

