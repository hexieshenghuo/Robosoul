%% �ӵ��в����ƶ�������
%% ˵��
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
   else %ȱʡ
        Num=sort(ceil(rand(1,M)*N));
   end
   samplePoints=Points(:,Num);
   
end