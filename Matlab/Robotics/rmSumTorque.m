%% �������ģ�͵ĺ�����

function [ rm ] = rmSumTorque( rm )
   rm.SumT=sum(cross(rm.r,rm.F),2)+sum(rm.T,2);
end