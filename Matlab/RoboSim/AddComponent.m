%% ���һ���̶��ṹ����������Part��ӵ����Componet
%%
% Componet:��ǰ���
% Part��Ҫ��ӵ������
% Type:���Part����
% Color����ɫ
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