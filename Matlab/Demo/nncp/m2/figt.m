%figt.m             ���Ʋ�����������
         %---1. ����������䣨������̬����ȡȨϵֵ��---   
function figt(v)
hold on;
axis square;
for j=1:8
    for i=1:7
        if v((j-1)*7+i)==0
            fill([i i+1 i+1 i],[9-j,9-j,10-j, 10-j],'k')
        else
            fill([i i+1 i+1 i],[9-j,9-j,10-j, 10-j],'w')
        end
    end
end
hold off