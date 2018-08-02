%% 例子 多旋翼无人机按Z轴旋转动画显示
%% 说明
%%
multiRotor=GetMultiRotor();

for theta=0:pi/360*10:pi*2
    
    clf;
    T=Rot(theta,'z');
    NewRotor= TransComponent(T,multiRotor);
    DrawComponent(NewRotor);
    SetShowState(600);
    drawnow;
    %%
   
end