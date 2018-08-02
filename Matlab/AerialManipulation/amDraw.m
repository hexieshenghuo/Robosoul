function amDraw( am )
   
   %% »­ËÄÐýÒí
   
   if ~isempty(am.qm.rm.Model3d)
       T=MT(am.qm.rm.R,am.qm.rm.P);
       showModel=TransComponent(T,am.qm.rm.Model3d);
       DrawComponent(showModel);
   end
  
   %% »­»úÐµ±Û
   for i=1:am.arm.LinkNum
       if ~isempty(am.arm.Link(i).Model3d)
           showLink=TransComponent(am.arm.Link(i).T,am.arm.Link(i).Model3d);
           DrawComponent(showLink);
       end
   end
end