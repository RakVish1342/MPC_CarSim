clear all; close all;

%% Global Parameters

global t_start t_step t_stop
global Ap Bp Cp Dp
global Q R G

t_start = 0.0;
t_step = 0.01;
t_stop = 30.0;

%% Vehicle Parameters

% Longitudinal velocity
vx = 10 % 36 kmph
% vx = 33.33 % 120 kmph

% Vehicle Parameters
% Class B Hatchback has been used.
m = 1110
Iz = 1343.1
lf = 1040*10^(-2) % lengths are in cm
lr = 2600*10^(-2) - lf % lengths are in cm

g = 9.81
Fz = m*9.81 % = 10889
Fzf = Fz/2
Fzr = Fz/2
Caf = (4074.59 - 656.5) / (4 - 0.5) % From the slope of the linear portion of the plot for Fz/2 = 54446 (Assuming equal load on front half and rear half)
Car = (4074.59 - 656.5) / (4 - 0.5) % From the slope of the linear portion of the plot for Fz/2 = 54446 (Assuming equal load on front half and rear half)

%% State Space Matrices

t1 = (- 2*Caf - 2*Car)/(m*vx);
t2 = (+2*Caf)/m;
t3 = (+2*Car)/m;
t4 = (+ 2*Car*lr - 2*Caf*lf)/(m*vx) - vx;

t5 = (+ 2*Car*lr - 2*Caf*lf)/(Iz*vx);
t6 = (+2*Caf*lf)/Iz;
t7 = (+2*Car*lr)/Iz;
t8 = (- 2*Caf*lf*lf - 2*Car*lr*lr)/(Iz*vx);

% Plant State space 4x4
Ap = [   0,  1,  0,  0; 
        0,  t1, 0,  t4;
        0,  0,  0,  1;
        0,  t5, 0,  t8  ];

Bp = [ 0,    0; 
      t2,   t3;
      0,    0; 
      t6,   t7  ];
  
Cp = eye(4); % Output all states
Dp = zeros(size(Bp));

sys = ss(Ap, Bp, Cp, Dp);

% Integrator States 2x2
Aa = zeros(2);
Ba = eye(2);
Ca = eye(2);
Da = zeros(2);

% Aug at input
Aaug = [Aa, zeros(2,4); Bp*Ca, Ap];
Baug = [Ba; Bp*Da];
Caug = [Dp*Ca, Cp];
Daug = Dp*Da;

sys = ss(Ap, Bp, Cp, Dp);

% Q = 10*eye(4);
% R = eye(2);
% [G, K, e] = lqr(Ap, Bp, Q, R);
Q = 1*eye(6);
R = 2*eye(2);
[G, K, e] = lqr(Aaug, Baug, Q, R);

% % Gains for integrator states
% Gz = G(:,1:2);
% % Gains for reference/output tracking states -- y, phi
% Gy = G(:,3:5);
% % Gains for remaining states -- y_dot, phi_dot
% Gr = G(:,4:6);

% load('reference_signal_timeseries.mat'); % Clearly, the yaw angle is in degrees...ranges till a value of 8 or so (Units not given in toolbox though)
load('reference_signal_timeseries_longer.mat'); 

% addpath('C:\opt\MATLAB\2019b\toolbox\matlab\system\@system');

out = sim('system_blocks');
