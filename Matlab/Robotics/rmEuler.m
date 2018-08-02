function [ rm ] = rmEuler( rm )
   
   rm.Euler=rm.Euler + rm.dt*rm.dEuler;
   
end