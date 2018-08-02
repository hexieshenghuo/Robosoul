%% ������ת��Patch
% Type��ת����ʽ ��c�� ΪȡԲ�� ��r�� ȡ������������

%%
function [Patch] = vector2Patch(X,width,Type)
Patch=zeros(width,width);
d=floor(width/2);
n=1;
switch Type
    case 'c' %Բ��
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %�ж��Ƿ���Բ��
                    Patch(y,x)=X(n);
                    n=n+1;
                end
            end
        end
    case 'r' %ȡ������
        Patch=reshape(X,width,width);
end
end

