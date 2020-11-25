%  https://www.mathworks.com/help/releases/R2017b/mpc/examples/autonomous-vehicle-steering-using-model-predictive-control.html?s_eid=PSM_15028

addpath(fullfile(matlabroot,'examples','mpc_featured','main'));


m = 1575;
Iz = 2875;
lf = 1.2;
lr = 1.6;
Cf = 19000;
Cr = 33000;

Vx = 15;


A = [-(2*Cf+2*Cr)/m/Vx, 0, -Vx-(2*Cf*lf-2*Cr*lr)/m/Vx, 0;
     0, 0, 1, 0;
     -(2*Cf*lf-2*Cr*lr)/Iz/Vx, 0, -(2*Cf*lf^2+2*Cr*lr^2)/Iz/Vx, 0;
     1, Vx, 0, 0];
B = [2*Cf/m 0 2*Cf*lf/Iz 0]';
C = [0 0 0 1; 0 1 0 0];
vehicle = ss(A,B,C,0);


T = 15;         % simulation duration
time = 0:0.1:T; % simulation time
% plotReference(Vx,time);
plot(Vx,time);


mdl = 'mpcVehicleSteering';
open_system(mdl)


Ts = 0.1;
mpc1 = mpc(vehicle,Ts);


mpc1.MV.RateMin = -0.26;
mpc1.MV.RateMax = 0.26;


mpc1.Weights.OV = [1 0.1];


sim(mdl)

