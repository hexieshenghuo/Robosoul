%% ����Patch
%% ˵��
function [ outPatch] = processPatch( Patch,proParam)
   switch proParam.ProMethod
       case 'Binary' % ��ֵ��
           thres=mean(mean(Patch));
           outPatch=Patch>=thres;
       case 'Discrete' % ��ɢΪ������
           DiscreteNum=proParam.DiscreteNum;
           Max=max(max(Patch));
           Min=min(min(Patch));
           d=(Max-Min)/DiscreteNum;
           outPatch=floor((Patch-Min)/d);
       case 'GradMag' %�ݶȸ�ֵ
           GradMethod=proParam.GradMethod;
           [outPatch,Ori]=imgradient(Patch,GradMethod);
       case 'Normal'
           outPatch=double(Patch)/255.0;
   end
   outPatch=double(outPatch);%תΪdouble���Ա����
           
end

