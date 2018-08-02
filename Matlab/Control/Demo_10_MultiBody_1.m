m1=1.258;
m2=2.58;

F=5.288;
f1=0;
f2=0;

Num=500;
a1=0;
a2=0;

plotf1=zeros(Num,1);
thres=0.00001;
lr=0.066;
for i=1:Num
    a1=(F-f1)/m1;
    f2=m2*a1;
    if ( abs(f1-f2) < thres )
        break;
    end
    g=(f1-f2)*(1+m2/m1);
    f1=f1-lr*g;
    plotf1(i)=f1;
end

plot(plotf1(1:i-1));hold on;
disp(f1);