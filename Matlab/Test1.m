A=eye(120)*9;
B=rand(120,1)*6;
X0=eye(120,1);
options = optimset('Display','off');
tic
X=fsolve(@(x) f(x,A,B),X0,options);
toc;