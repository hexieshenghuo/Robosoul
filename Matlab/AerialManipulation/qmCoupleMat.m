%% ������ת�٦ص�������[F; ��]����Ͼ���
%% ˵��
% CoupleMat����=[F; ��]
% qm: quadrotorģ�� ��������
% 

function [  qm,varargout ] = qmCoupleMat( qm )
   
   Ktf=qm.Ktf;
   Kct=qm.Kct;
   Num=qm.RotorNum;
   Mt=zeros(3,Num);
  
   Sign=ones(Num,1);
   for i=1:Num
       if norm(qm.Fn(:,i)-qm.Tn(:,i))>1
           % �����෴
           Sign(i)=-1;
       else
           % ����һ��
           Sign(i)=1;
       end
   end
   
   for i=1:Num
       Mt(:,i)=qmSt(qm.rF(:,i),Ktf,Kct,Sign(i))*qm.Fn(:,i);
   end
   
   qm.CoupleMat=[Ktf*qm.Fn; Mt];

   if nargout>1
       varargout{1}=qm.CoupleMat;
   end
   
end

