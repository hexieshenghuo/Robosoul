%% ��Ϊʶ��������ͼ

Type=1;  % 1: �������� 2����txt����
N=10;    % ��Ϊ����� >10�е�����
MeanPrecision=88;
if (Type==1)
    D=importdata('Data.txt');
    Label=D.textdata;
    
    CM=rand(N)*8;
    Main=diag(rand(N,1)*5 +MeanPrecision);
    
    CM=CM+Main;
    getConfusionMat(CM,Label);
    
else
    D=importdata('Data.txt');
    M=D.data;
    Label=D.textdata;
    getConfusionMat(M,Label);
end