%% 从点中采样制定数量点
%% 说明
%% 
function [ samplePoints ] = sampleFromPoints(Points,M,varargin)
   N=length(Points);
   if N<=M
       samplePoints=Points;
       return;
   end
   
   if nargin>2
       d=N/M;
       Num=ceil(1:d:N);
   else %缺省
        Num=sort(ceil(rand(1,M)*N));
   end
   samplePoints=Points(:,Num);
   
end