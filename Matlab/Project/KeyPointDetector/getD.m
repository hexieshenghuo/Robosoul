%% ����width��Type����D
%% ˵��
%%
function [D] = getD(width,Type)
   D=0;
   switch Type
    case 'c' %Բ��
        d=floor(width/2);
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %�ж��Ƿ���Բ��
                    D=D+1;
                end
            end
        end
    case 'r' %ȡ������
        D=width^2;
   end

end

