%% 计算由转速ω到广义力[F; τ]的耦合矩阵
%% 说明
% CoupleMat·ω=[F; τ]
% qm: quadrotor模型 包括参数
% 

function [  qm,varargout ] = qmCoupleMat( qm )
   
   Ktf=qm.Ktf;
   Kct=qm.Kct;
   Num=qm.RotorNum;
   Mt=zeros(3,Num);
  
   Sign=ones(Num,1);
   for i=1:Num
       if norm(qm.Fn(:,i)-qm.Tn(:,i))>1
           % 方向相反
           Sign(i)=-1;
       else
           % 方向一致
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

