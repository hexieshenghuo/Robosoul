%% BFGS��������1
%% ˵��
% objFunc(X,Data):���ڲ��Ե�Ŀ�꺯�� �ɸ���
%%
function SetX= bfgsExample1()
   X=[1;3];
   H=eye(2);
   WolfeParam=getWolfeParam();
   Data=1;
   fk=0;
   gk=0;
   SetX=[X];
   for i=1:100
       [X,H,fk,gk] = BFGS(@objFunc,X,Data,H,WolfeParam);
       SetX=[SetX X];
       if isStop(gk,0.0000001);
           break;
       end
       figure(1);
       x=SetX(1,:);
       y=SetX(2,:);
       plot(x,y);
   end
   
   fprintf('���Ž⣺%f ���ź���ֵ��%f',X,fk);
   
end

function [f,g]=objFunc(X,Data)
t=X(1);
s=X(2);
f=t^2-t*s+(sin(t^2)^2)*s+s^2+2;
g1=2*t-s+2*s*sin(t^2)*cos(t^2)*2*t;
g2=-t+2*s+sin(t^2)^2;
g=[g1;g2];
end