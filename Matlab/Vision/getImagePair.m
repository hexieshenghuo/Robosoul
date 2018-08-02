function Show=getImagePair(I1,I2)
sizeI1=size(I1);
sizeI2=size(I2);

channel_1=length(sizeI1);
channel_2=length(sizeI2);

if channel_1>2
    channel_1=3;
else
    channel_1=1;
end

if channel_2>2
    channel_2=3;
else
    channel_2=1;
end
channel=max(channel_1,channel_2);

height=max(sizeI1(1),sizeI2(1));
width=sizeI1(2)+sizeI2(2);
Show=im2uint8(zeros(height,width,channel));
Show(1:sizeI1(1),1:sizeI1(2),:)=I1;
Show(1:sizeI2(1),sizeI1(2)+1:sizeI1(2)+sizeI2(2),:)=I2;
end