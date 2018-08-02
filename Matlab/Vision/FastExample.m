%%fast�ǵ�������
FileName='F:/RoboSoul/TestData/Images/Freak1.jpg';
%'F:/RoboSoul/Config/Samples/good_5/N6.jpg'; %

i = imread(FileName);

%Make image greyscale
if length(size(i)) == 3
 	im =  double(i(:,:,2));
%    im = rgb2gray(i);
else
% 	im = double(i);
   
end
cs = fast_corner_detect_9(im, 30);
c = fast_nonmax(im,30, cs);

% image(im/4);
handle=image(i);
axis image;
colormap(gray);
hold on;
plot(cs(:,1), cs(:,2), 'r.')
plot(c(:,1), c(:,2), 'g.')
legend('9 FAST �ǵ�', 'nonmax-suppressed �ǵ�');
title('Fast�ǵ�����Գ���');


