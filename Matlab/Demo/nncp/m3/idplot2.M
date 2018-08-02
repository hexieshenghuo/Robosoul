function idplot2(z,int,T,ny,PC)
%IDPLOT	Plots input - output data
%
%	idplot(Z)   or   idplot(Z,INT)
%
%	Z is the input - output data [y u]. This is plotted with output over
%	input. The data points specified in the row vector INT are selected.
%	The default value is all data.
%	If the sampling interval is T, correct time axes are obtained by
%
%	idplot(Z,INT,T)
%
%	If the data is multi-output, appropriate plots are obtained by
%
%	idplot(Z,INT,T,NY)
%
%	where NY is the number of outputs, i.e the ny first columns of Z.
%
%	It is assumed that the input is piecewise constant between sampling
%	instants, and it is plotted accordingly. If linear interpolation
%	between input data points is preferred, use
%	
%	idplot(Z,INT,T,NY,'LI')

%	L. Ljung 87-7-8, 92-1-25
%	Copyright (c) 1987-92 by The MathWorks, Inc.
%	All Rights Reserved

if nargin<5, PC='PC';end
if nargin<4, ny=1;end,if isempty(ny),ny=1;end
if nargin<3, T=1;end,if isempty(T),T=1;end,if T<0,T=1;end
if nargin<2, int=1:length(z(:,1));end
if isempty(int),int=1:length(z(:,1));end
[N,nz]=size(z);nu=nz-ny;
clf reset
if nz==1,plot(T*int,z(int,1)),title('输出数据'),return,end

for ky=1:ny
for ku=1:nu
   if PC~='PC',plot(T*int,z(int,ny+ku)),end
   if PC=='PC'
   	ax=axis;
	xa(1:2:2*length(int)-1)=T*int;
	xa(2:2:2*length(int)-1)=T*int(2:length(int));
	ya(1:2:2*length(int)-1)=z(int,ny+ku);
	ya(2:2:2*length(int)-1)=z(int(1:length(int)-1),ny+ku);
	y1=min(ya);y1=y1-0.1*abs(y1);
   y2=max(ya);y2=y2+0.1*abs(y2);
   v=[0 0];e=[1.1 1];
   %subplot(211),
   plot(v,e);hold on;plot(xa,ya);%hdld on;%plot(v,e);
	%title('输入输出样本对图(取1—90对)','Color','g','fontsize',16);
        %axis([ax(1:2) y1 y2]);
    end
    ylabel('系统、辨识器输入u(k)','color','r','fontsize',13)
    if ky+ku<nz,pause,end
    %subplot(212),plot(T*int,z(int,ky))
    ylabel('系统、辨识器输入u(k)','color','r','fontsize',13);xlabel('(a)   k')
end
end

%set(gcf,'NextPlot','replace');

