function [ u ] = pidController( Kp,Ki,Kd ,e,Se,de)

   u=Kp*e+Ki*Se+Kd*de;
   
end

