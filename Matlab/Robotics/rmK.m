%% ¸üÐÂK
%% 
function [ rm ] = rmK( rm )
   a=norm(rm.W_b);
   if (a<eps*100)
       rm.K=eye(3);
   else
       rm.K=MR(KRot(rm.W_b/a,rm.dt*a));
   end
end