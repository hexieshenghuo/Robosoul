%% 根据D-H参数 计算机械臂的Jacobian矩阵
%% 说明：符号形式的
%
%
%
function [ J ,varargout] = symJacobianDH(varargin)    

      L=sym('L',[5 1]);
      theta=sym('theta',[4 1]);
      dt=sym('dt',[4 1]);
      
      dh=[ 0          0        0           theta(1);...
          L(1)        0        0           theta(2);...
          L(2)        -pi/2    0           theta(3);...
          0           -pi/2    L(3)        theta(4);...
          0           0        L(4)+L(5)   0];
      
      A1=DHTrans(dh(1,:),2);
      A2=DHTrans(dh(2,:),2);
      A3=DHTrans(dh(3,:),2);
      A4=DHTrans(dh(4,:),2);
      A5=DHTrans(dh(5,:),2);
      
      T=A1*A2*A3*A4*A5;
      
      
     %% Jv  关节速度与末端相对基坐标速度的Jacobian
      P=Vp(T);
      
      Jv=jacobian(P,theta);
      Jv=simplify(Jv);
      
    %% Jw 关节速度与末端相对基坐标转速的Jacobian
     R=MR(T);
     
     vR=reshape(R,9,1);% 3×3 R->9×1向量
     dR=jacobian(vR,theta)*dt;
     dR=reshape(dR,3,3);
     
     Sw=dR*R.';
     Sw=simplify(Sw)
     
     %
     F=[-Sw(2,3);Sw(1,3);-Sw(1,2)];
     Jw=jacobian(F,dt);
     
     J=[Jv;Jw];
     
     if nargout>1
         varargout{1}=Jv;
     end
     %%
     
     %%
     if nargout>2 % 
         varargout{2}=Jw;
     end
end

