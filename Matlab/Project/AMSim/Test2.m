DH= sym('DH',[4,4]);

[A,F]=updateTrans(DH);
f=matlabFunction(F{1});
% res=SymbolTest(F,DH,[pi/2;0;3;pi/3])
% res=SymbolTest(F,[pi/2;0;3;pi/3]);