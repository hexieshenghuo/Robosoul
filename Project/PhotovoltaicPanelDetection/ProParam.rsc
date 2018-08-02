QualityLevel : 0.016
MinDis :  6
BlockSize :  5
K  :   0.016 
UseHarris : 1
HarrisROI : x 100,  y  120,  width 500,  height 300    //Harris角点检测的区域
PointMaxNum : 1258
SubTerm  :  type :   3,  max_iter  :  36,  epsilon : 0.01
SubSize  :   9   % 9
LKSize   :   9   % 9
LKLevel  :   3
LKTerm   :  type :  3,  max_iter  :  36,  epsilon : 0.01
LKFlag    :   3
HomoMethod :  8      % CV_RANSAC
ransacThres  :   3   
ResSize : width   6000,   height 728
StitchROI  :   x  100,  y  30,  width 460,  height 200     // 图像拼接的子区域，以降低畸变 目前没有用到
VertShortStep   :  3          //小步检测
VertLongStep    :  39      //大步检测
VertWidth       :  9      // 15 垂直方向直线检测区域的宽度 重要
VertHeight      :  360       //垂直方向直线检测区域的高度
VertRect        :  x 30,  y  60,  width 660,  height 369       //垂直直线的检测域
VertThres       :  0.0039   //垂直阈值
xOrder          :  2     //Sobel X阶数
VertLsdScale    :  0.36
VertLsdGain     :  100.0   // 100 比较好
VertMethod      :  0
HorShortStep   :  10          //小步检测
HorLongStep    :  36      //大步检测
HorWidth       :  300     //垂直方向直线检测区域的宽度
HorHeight      :  15        //  15 垂直方向直线检测区域的宽度 重要
HorRect        :  x 10,    y  30,  width 660,  height 390       //垂直直线的检测域
HorThres       :  0.066   //垂直阈值
yOrder         :  2       //Sobel y阶数
HorLsdScale    :  0.36
HorLsdGain     :  100.0   //100 比较好
HorMethod      :  0
SpotRect       :  x 60,    y  60,  width 600,  height 390       //
HeatConfig     :  threshold  219, EDnum  2   
IsRelease      :  1      // 发布是1 不发布是0