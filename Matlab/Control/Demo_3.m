%% 二阶系统控制PID控制
model.ddy=0;
model.dy=0;
model.y=0;

Yt=6;

dt=0.01;

kp=6;
ki=6;
kd=3.8;


T=3;
Se=0;
oldE=0;
num=length(0:dt:T);

Y=zeros(num,1);

for t=1:num
    e=Yt-model.y;
    de=(e-oldE)/dt;
    Se=Se+e*dt;
    oldE=e;
    r=pidController(kp,ki,kd,e,Se,de);
    
    model=demoModel(model,r,dt);
    
    Y(t)=model.y;
end

plot([0 0:dt:T],[0 ;Y],'color','b');hold on;

YT=Yt*ones(num+1,1);
plot([0 0:dt:T],YT,'color','r');hold on;