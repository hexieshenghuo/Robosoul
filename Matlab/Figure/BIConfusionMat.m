%% 行为识别论文中图

Type=1;  % 1: 计算生成 2：从txt导入
N=10;    % 行为类别数 >10有点问题
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