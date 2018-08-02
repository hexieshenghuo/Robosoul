%m551maxtu.m
clear all;
close all;
[x,y]=meshgrid(-2.048:2.048/10:2.048,-2.048:2.048/10:2.048);
z=100*(x.^2-y).^2+(1-x).^2;
x1=-2.048;
y1=-2.048;
z1=100*(x1^2-y1)^2+(1-x1)^2;
x2=2.048;
y2=-2.048;
z2=100*(x2^2-y2)^2+(1-x2)^2;

mesh(x,y,z);hold on;plot3(x1,y1,z1,'ro','LineWidth',2);
            hold on;plot3(x2,y2,z2,'ro','LineWidth',2)
            xlabel('x');ylabel('y');zlabel('z');
            title('-Rosenbrock Function  及最优解:[z,x,y]=[3906,-2.048,-2.048]   次优解:[3898,2.048,-2.048]');
