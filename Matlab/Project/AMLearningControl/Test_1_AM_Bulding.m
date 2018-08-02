%% 旋翼机械臂模型利用脚本方式导入并显示

   AM=amLoadModel('amModelScript.m');
   
   amDraw(AM);
   
   SetShowState(0.5);
   
%    axis([-0.6 0.6 -0.6 0.6 -1.8 0.3]);
%%