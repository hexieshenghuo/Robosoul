function u=prbs(n1,n,k1,k2,k3,k4)

for i=1:n1
    s(i)=-1;
end
m=1;
while m<=n
  u(m)=s(n1);
  ss(1)=s(k1);
  ss(2)=s(k2);
  for i=1:n1-1
      j=n1-i;
      s(j+1)=s(j);
  end     
  if k3==0
     s(1)=ss(1)*ss(2);
  else
     s(1)=s(k1)*s(k2)*s(k3)*s(k4);
  end
  m=m+1;
end     