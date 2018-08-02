%% 计算机械臂末端执行器坐标系（最后一个坐标系）原点到基坐标系的位置
%% 说明

function [ Pe ] = armGetPe( arm )
   T=eye(4);
   
   for i=1:arm.LinkNum
       A=arm.Link(i).Aconst*arm.Link(i).Avar;
       T=T*A;
   end
   Pe=Vp(T); 
end