%% ��Patchת������
%% ֻ֧�ֻҶ�ͼ��
% Type��ת����ʽ ��c�� ΪȡԲ�� ��r�� ȡ������������

%%
function [X,varargout] = patch2Vector(Patch,width,Type)
X=[];
d=floor(width/2);
switch Type
    case 'c' %ȡԲ��
        [cx,cy]=getCenter(width,width);
        for x=1:width
            for y=1:width
                if norm([x-cx y-cy])<d %�ж��Ƿ���Բ��
                    X=[X;Patch(y,x)];
                end
            end
        end
    case 'r' %ȡ������
        X=reshape(Patch,width*width,1);
end
X=double(X);
varargout{1}=length(X);% D:Vectorά��
end
