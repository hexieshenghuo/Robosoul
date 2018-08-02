DH=[pi/4 0 60 0; -pi/2 0 60 0; pi/3 0 60 0; -pi/2 0 60 0; -pi/2 0 60 0; -pi/2 0 60 0];
Model=GetArmModel_2(DH); 
DrawComponent(Model.ShowComponent);
SetShowState([-10,180,-80,80,-90,90]);
% SetShowState(80);