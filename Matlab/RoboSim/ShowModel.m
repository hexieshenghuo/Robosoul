%% 显示一个3D模型
function [ res ] = ShowModel(Model,DH )

[N,Col]=size(DH);
[A,T]=updateTrans(DH);

Component=CreateComponent();
BaseT=Model.BaseCoord;
Model.BaseComponent=TransComponent(BaseT,Model.BaseComponent);
Component=JointComponents(Component,Model.BaseComponent);

if N>0
    for i=1:N
        %Model.JointComponent{i}=TransComponent(BaseT*T{i},Model.JointComponent{i});
        %Component=JointComponents(Component,Model.JointComponent{i});
    end
end
DrawComponent(Component);
end

