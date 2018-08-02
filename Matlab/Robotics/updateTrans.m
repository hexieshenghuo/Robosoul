%% 根据D-H参数计算Ai 与Ti
%%
% A: 坐标系i相对于坐标系i-1的变换矩阵,数据形式为cell 
% A{i}代表一个关节矩阵
% T: 坐标系i相对于基坐标（坐标系0）的变换矩阵数据形式为cell
% T{i}代表一个关节到世界坐标系的矩阵
% DH：D-H参数 每一行为一组D-H参数

function [A,T] = updateTrans( DH )
   [N,M]=size(DH);
   A=cell(N,1);% 坐标系i与i+1的变换矩阵
   T=cell(N,1);% 坐标系i与0的变换矩阵
   A{1}=DHTrans(DH(1,:));
   T{1}=A{1};
   for i=2:N
       A{i}= DHTrans(DH(i,:));
       T{i}=T{i-1}*A{i};
   end
end

