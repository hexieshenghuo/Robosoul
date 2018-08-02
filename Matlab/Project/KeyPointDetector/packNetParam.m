%% 将网络参数打包至Param结构
%% 说明
% Param：参数结构包括：
% Alpha：
% C：
% S：
% W：
% D:维数
% H:隐层数
% a: sigmoid函数缩放比例
%%
function [NetParam] = packNetParam(Alpha,C,S,W,D,H,a)
NetParam.Alpha=Alpha;
NetParam.C=C;
NetParam.S=S;
NetParam.W=W;
NetParam.D=D;
NetParam.H=H;
NetParam.a=a;
end

