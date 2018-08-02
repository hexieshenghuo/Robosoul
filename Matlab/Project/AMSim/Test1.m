%% 测试不同坐标系间速度关系
d=[10;300;0;1];
BodyCoord=Trans(d);

Vel_I=[1 30 0]';
w=pi*2;
W_I=[0 0 w]';

dt=0.001;

T=10;
P=[];
for t=0:dt:T
 J=[MR(BodyCoord) zeros(3);zeros(3) MR(BodyCoord)];
  %J=BJA(BodyCoord);
  
  Vel=inv(J)*[Vel_I;W_I];
   
  dv=Vel*dt;
  
  K=KRot( Normalize( dv(4:6) ), norm(dv(4:6)) );
  BodyCoord=BodyCoord*Trans(dv(1:3))*K;
  P=[P Vp(BodyCoord)];
end
plot(P(1,:),P(2,:));