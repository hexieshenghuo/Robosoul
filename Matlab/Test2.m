demo3=demo;
for i=1:75
    demo3(:,i)=smooth(demo(:,i),3,'moving'); %'rloess' 'rlowess'
end

demo4=demo2;
for i=1:75
    demo4(:,i)=smooth(demo2(:,i),3,'moving'); %'rloess' 'rlowess'
end


d1=diff(demo3);
d2=diff(demo4);

subplot(2,2,1);
plot(demo3,'DisplayName','demo');
subplot(2,2,2);
plot(demo4,'DisplayName','demo2');

subplot(2,2,3);
plot(d1,'DisplayName','demo');
subplot(2,2,4);
plot(d2,'DisplayName','demo2');