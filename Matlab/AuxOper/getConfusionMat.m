%% 绘制混淆矩阵
%%
%  感谢作者“丕子”
%  参数：mat-矩阵；tick-要在坐标轴上显示的label向量，例如{'label_1','label_2'...}
%
%%
function getConfusionMat(mat,tick)
imagesc(mat);            % 绘彩色图
colormap(flipud(gray));  % 转成灰度图，因此高value是渐黑色的，低value是渐白的
num_class=size(mat,1);
 
textStrings = num2str(mat(:),'%0.2f');
textStrings = strtrim(cellstr(textStrings));
[x,y] = meshgrid(1:num_class);
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));
textColors = repmat(mat(:) > midValue,1,3);
%改变test的颜色，在黑cell里显示白色
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors
 
set(gca,'xticklabel',tick,'XAxisLocation','top');
% rotateXLabels(gca, 45 );
 
set(gca,'yticklabel',tick);
% axis equal;