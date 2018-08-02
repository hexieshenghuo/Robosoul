%% 添加一个固定结构的零件将组件Part添加到组件Componet
%%
% Componet:当前组件
% Part：要添加的子组件
% Type:组件Part类型
% Color：颜色
function [ Component ] = AddComponent(Component,Part,Type,Color)
   
   l=length(Component);
   if(l==1 && Component.Use==0)
       Component(1).Part=Part;
       Component(1).Type=Type;
       Component(1).Color=Color;
       Component(1).Use=1;
   else
       Component(l+1).Part=Part;
       Component(l+1).Type=Type;
       Component(l+1).Color=Color;
       Component(l+1).Use=1;
   end

end