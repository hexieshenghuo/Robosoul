%% ����D-H�������ɱ任���� D-H�任����!
%%
% DH: D-H����˳��Ϊ �� d a ��
%
function [Mat] = DHTrans(dh,varargin)

if(nargin<2)
    %% ��һ��D-H����
    theta=dh(1);
    d=dh(2);
    a=dh(3);
    alpha=dh(4);
    
    cosTheta=cos(theta);
    sinTheta=sin(theta);
    
    cosAlpha=cos(alpha);
    sinAlpha=sin(alpha);
    
    Mat1=[cosTheta, -1*sinTheta*cosAlpha, sinTheta*sinAlpha,  a*cosTheta];
    Mat2=[sinTheta, cosTheta*cosAlpha, -1*cosTheta*sinAlpha, a*sinTheta];
    Mat3=[0 sinAlpha cosAlpha d];
    
    Mat=[Mat1;Mat2;Mat3;[0 0 0 1]];
else
    %% �ڶ���D-H����
    Tx=Trans([dh(1);0;0;1]);
    Rx=Rot(dh(2),'x');
    Tz=Trans([0;0;dh(3);1]);
    Rz=Rot(dh(4),'z');
    
    Mat=Tx*Rx*Tz*Rz;
end

end