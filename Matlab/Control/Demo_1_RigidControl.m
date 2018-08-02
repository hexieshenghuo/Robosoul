%% һ������Ķ��������ʾ����
%% �����������۹��� ����ƽ��

% ����ģ��
Model=getModel();

% ���Ʋ���
Kp=1.2;   % P����
Ki=0.06;   % I����
Kd=1.0;    % D����
E=0;
oldE=0;
dE=0;
SumE=0;

Wg=10;
N=30;

Angle=[-pi/2];
Omiga=[Model.Omiga];
dOmiga=[Model.dOmiga];

type=1;
figure(1);
for i=1:N
    
    clf;
    %% ����
    E=Model.Angle-0;
    SumE=SumE+E;
    dE=E-oldE;
    % PID
    if type==1    
        W=Kp*E+Ki*SumE+Kd*dE;
        oldE=E;       
        w1=max(Wg,Wg+0.5*W); 
        w2=max(Wg,Wg-0.5*W);
        [Model a o d ]= UpdateModel(Model,w1,w2);
    else
        vel=Kp*E+Ki*SumE+Kd*dE;
        [Model a o d ]= UpdateModel(Model,-vel);
    end
    Angle=[Angle a];
    Omiga=[Omiga o];
    dOmiga=[dOmiga d];
    
    Coord=GetCoord(30);
    Coord=TransCoord(Rot(Model.Angle,'y'),Coord);
    ShowBox=TransBox(Rot(Model.Angle,'y'),Model.ThreeDModel);
    
    if 1>2
        subplot(4,1,1);
        DrawCoord(Coord,1);
        DrawBox(ShowBox,'g');
        SetShowState(20);
        subplot(4,1,2);
        plot( Angle);
        subplot(4,1,3);
        plot(Omiga);
        subplot(4,1,4);
        plot( dOmiga);
        
    else
        DrawCoord(Coord,1);
        DrawBox(ShowBox,'g');
        SetShowState(20);
    end
    drawnow;   
%pause(0.1);
    
end
% clf;
figure(2);
plot( Angle);