[ QM ] = qmDefaultQuadrotorModel( );
M=QM.CoupleMat;

m3=M(4:6,:);
em3=[m3;0 0 0 1];
eim3=inv(em3);

eim3*em3

im3=eim3(:,1:3);

im3*m3