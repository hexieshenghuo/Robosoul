function [ model ] = demoModel( model ,r ,dt)
  y=model.y;
  dy=model.dy;
  model.ddy=9*r-6*dy-9*y;
  
  model.dy= dy + dt*model.ddy;
  model.y=  y  + dt*model.dy;

end