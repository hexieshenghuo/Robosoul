%% 初始化参数NetParam
%% 说明
% Data：初始化所需数据
% D：输入维数
% H: 网络层数
% a：符号函数缩放参数：y=1/(1+exp(-aX))
%%
function [NetParam] = initialNetParam(DataVectors,D,H,a)
%
%    DataMat=dataVectors2Mat(DataVectors);
%初始化网络参数
   NetParam.Alpha=ones(D,H);%rand(D,H)-0.5;
   NetParam.S=ones(H,1)*10;
   NetParam.W=(rand(H,1)-0.5)*60;%zeros(H,1);%;
   %用K-Means聚类初始化C
   
   %[inx,C]=kmeans(DataMat',H);
   %NetParam.C=C';
   NetParam.C=(rand(D,H)>=0.5);%rand(D,H);%
   NetParam.a=a;
   NetParam.D=D;
   NetParam.H=H;
end