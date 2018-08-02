%% 处理Patch
%% 说明
function [ outPatch] = processPatch( Patch,proParam)
   switch proParam.ProMethod
       case 'Binary' % 二值化
           thres=mean(mean(Patch));
           outPatch=Patch>=thres;
       case 'Discrete' % 离散为几个点
           DiscreteNum=proParam.DiscreteNum;
           Max=max(max(Patch));
           Min=min(min(Patch));
           d=(Max-Min)/DiscreteNum;
           outPatch=floor((Patch-Min)/d);
       case 'GradMag' %梯度赋值
           GradMethod=proParam.GradMethod;
           [outPatch,Ori]=imgradient(Patch,GradMethod);
       case 'Normal'
           outPatch=double(Patch)/255.0;
   end
   outPatch=double(outPatch);%转为double型以便计算
           
end

