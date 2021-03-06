clear all; close all;

%% Global Parameters

global t_start t_step t_stop
global A B C D

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

A = [   0,  1,  0,  0; 
        0,  t1, 0,  t4;
        0,  0,  0,  1;
        0,  t5, 0,  t8  ];

B = [ 0,    0; 
      t2,   t3;
      0,    0; 
      t6,   t7  ];

% C = eye(4); % Output all states
% D = zeros(size(B));

sys = ss(A, B, C, D);

% load('mpc1_10kmph.mat');
% load('mpc1_10kmph_noLimits.mat');
load('mpc1_10kmph_betterLimits_butSoftRateLts.mat');

% load('reference_signal_timeseries.mat'); % Clearly, the yaw angle is in degrees...ranges till a value of 8 or so (Units not given in toolbox though)
load('reference_signal_timeseries_longer.mat'); 

out = sim('system_blocks');
