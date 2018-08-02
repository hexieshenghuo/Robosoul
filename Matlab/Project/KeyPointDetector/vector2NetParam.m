%% 将训练参数的向量形式转为Param结构，更新NetParam
%  顺序为：Alpha C S W
%% 其中
% Alpha：D×H
% C：D×H
% S：H×1
% W：H×1
% D：输入的维数
% H：隐层节点个数

%% 注意参数的梯度与其有相同维度，如 C 与 df/dC 都是D×H
%% 因此对于梯度的转换也可以用该函数
%%
function [NetParam] = vector2NetParam(Vector,D,H,a)
   step=D*H; %分段的步长
% Alpha
   alpha=Vector(1:step);
   alpha=reshape(alpha,D,H);
% C
   c=Vector(step+1:2*step);
   c=reshape(c,D,H);
% S
   s=Vector(2*step+1:2*step+H);
% W
   w=Vector(2*step+H+1:2*step+2*H);
   NetParam.Alpha=alpha;
   NetParam.C=c;
   NetParam.S=s;
   NetParam.W=w;
   
   NetParam.D=D;
   NetParam.H=H;
   NetParam.a=a;
end