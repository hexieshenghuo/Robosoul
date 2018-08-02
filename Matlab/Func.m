function [dy]=Func( t,y ,F,m,I,tor)
   
   Vb=y(1:3);
   Wb=y(4:6);
   
   invI=inv(I);
   
   F1=1/m*F+Sw(Wb)*Vb;
   F2=invI*(tor - Sw(Wb)*I*Wb);
   
   dy=[F1;F2];
   
   
end