
A3=A1;
for i=1:75
    A3(:,i)=smooth(A1(:,i),3,'moving'); %'rloess' 'rlowess'
end

d1=diff(A3);
d2=diff(A2);

subplot(2,2,1);
plot(A3,'DisplayName','demo');
subplot(2,2,2);
plot(A2,'DisplayName','demo2');

subplot(2,2,3);
plot(d1,'DisplayName','demo');
subplot(2,2,4);
plot(d2,'DisplayName','demo2');