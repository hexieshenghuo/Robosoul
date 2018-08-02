%% 合成两个组件
function [Component1] = JointComponents(Component1,Component2)
   n1=length(Component1);
   n2=length(Component2);
   for i=1:n2
       Component1(n1+i).Part=Component2(i).Part;
       Component1(n1+i).Type=Component2(i).Type;
       Component1(n1+i).Color=Component2(i).Color;
       Component1(n1+i).Use=1;
   end

end

