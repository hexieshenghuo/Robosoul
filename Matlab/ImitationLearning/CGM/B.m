%% B-Spline ������
% 
% t������
% i������t��ָ��
% k���״�
% T��
function  b=B(t,i,k,T)
   if k==1
       b=(T(i)<=t)&(t<T(i+1));
       return;
   else
       A=0*t;
       C=0*t;
       if abs(T(i+k-1)-T(i))>0 %1e-18 2016.08.25
           A=(t-T(i))./(T(i+k-1)-T(i));
       end
       if abs(T(i+k)-T(i+1))>0 %1e-18 2016.08.25
           C=(T(i+k)-t)./(T(i+k)-T(i+1));
       end
       b=A.*B(t,i,k-1,T)+C.*B(t,i+1,k-1,T);
   end
end