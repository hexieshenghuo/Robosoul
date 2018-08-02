function SetShowState(scale,varargin)
   camlight;
   grid on;
   axis equal;
   n=length(scale);
   if n>1
       axis(scale);
   else 
       if nargin>1
           P=varargin{1};
           axis([-scale+P(1), scale+P(1), -scale+P(2), scale+P(2), -scale+P(3), scale+P(3)]);
       else
           axis([-scale scale -scale scale -scale scale]);
       end
   end
end

