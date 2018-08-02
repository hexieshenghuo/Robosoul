%% 计算刚体模型的合力矩

function [ rm ] = rmSumTorque( rm )
   rm.SumT=sum(cross(rm.r,rm.F),2)+sum(rm.T,2);
end