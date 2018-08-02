%% 计算当前刚体模型的合力
function [ rm ] = rmSumForce(rm)
   rm.SumF=sum(rm.F,2);
end