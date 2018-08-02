%得到圆心为[0 0 0] Z=0的圆!
function [P] = GetDisc(R,N,Offset)
theta=0:pi*2/N:pi*2;
X=cos(theta)*R;
Y=sin(theta)*R;
Z=zeros(1,length(X));
P=[X;Y;Z;ones(1,length(X))];

%加偏移!
offset=repmat(Offset,1,length(P));
P=P+offset;

end

