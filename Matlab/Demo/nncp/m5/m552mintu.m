%m552mintu.m             Rosenbrock Function
clear all;
close all;
[x,y]=meshgrid(-1:0.1:1.5,-1:0.1:1.5);
z=100*(x.^2-y).^2+(1-x).^2;
x1=1;
y1=1;
z1=100*(x1^2-y1)^2+(1-x1)^2
mesh(x,y,z);hold on;plot3(x1,y1,0.5,'r*','LineWidth',2);
            xlabel('x');ylabel('y');zlabel('z');
            title('Rosenbrock Function  及  极小值:[z,x,y]=[0,1,1] ');
           

