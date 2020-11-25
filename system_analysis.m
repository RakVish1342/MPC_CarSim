clear all; close all;

%% Vehicle Parameters

% Longitudinal velocity
vx = 10 % 36 kmph

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

C = eye(4); % Output all states
D = zeros(size(B));

sys = ss(A, B, C, D)

%% Controllability and Observability

disp("Controllability Analysis")
ct = ctrb(sys)
if(length(A) - rank(ct) > 0)
    disp("The system is not controllable");
else
    disp("The system is controllable");
end

disp("Observability Analysis")
ob = obsv(sys)
if(length(A) - rank(ob) > 0)
    disp("The system is not observable");
else
    disp("The system is observable");
end

%% Poles, Zeros, Eigenvectors, Zero Vectors

H = tf(sys) % NOTE: Denominator of all TFs is the same/common since Dr ==nt (sI - A)^(-1)
H_min = minreal(H);

p = pole(H) % poles % gives the poles of the system with the corresponding multiplicities.

% Is this a valid way to find eigen vectors of for a MIMO system?
[eigvec, eigvals] = eig(sys.A) % poles = eigenvalues of A (since poles = inv(sI-A)). eig() can also give corsp eigenvectors (via right null space of sI-A for each eig vector. Why right null space = eig vector? Simplify (take to left and extract v as common): A*v = lambda*v)

[tz, nrank] = tzero(H_min) % transmission zeros
% To get corsp zero vectors/zero directions, need to find right null space
% of [sI-A, -B; C, D] matrix, for each zero value

zerVecs = []; % depend on how many zeros are there
for i = 1:length(tz)
    zer = tz(i);
    mat = [zer*eye(size(A))-A, -B; C, D];
    % mat*zerVec = 0
    % zerVec = inv(mat)*0
%     zerVec = mat\zeros(length(mat));
    zerVec = null(mat);
    zerVecs = [zerVecs zerVec];
end
disp(zerVecs);
    

%%%%%% Do eig vec


%% Frequency Analysis

% Frequency response for each of the TFs (Transfer Functions) in the 
% TFM(Transfer Function Matrix for the system
figure(1);
bode(H) % margin(H) works only for SISO systems


% One plot for each input. Basically merges the resultant of all the
% outputs for a given input. ie. Like a sum/combination of all the Bode
% plots for a particular input, taken across all of its corresponding
% output.
figure(2);
sigma(H)


% minreal(H) shows same H. So already minimal realization of system. ie. no
% pole zero cancellation. Tested with large tolerance of 100000*eps also.
% Since common poles and zeros exist, try to prove the same by looking for 
% eigen vectors and x-u vectors and seeing that they aren't alligned

%% Coupling at Low Frequencies

%How is this analysed?


%% Step Response

% Interpretation of results in the 4x2 matrix of plots:

% (1,1) shows how for some forward steering input, the output (lateral
% position) changes with a linear slope/at a constant rate
% (1,2) is similar to (1,1), but shows how the rear steering angle affects
% the lateral position. Its effect is a little more pronounced. From a
% physics standpoint this makes sense since the object is being pushed from
% behind the C.G

% (2,1) and (2,2) show that for a step input to the front and rear wheel
% respectively, the lateral velocity picks up/spikes at the time the
% control signal is provided, and then remains constant as the same control
% is provided.

% Similar to the above understanding for lateral position and lateral
% velocity, rows 3 and 4 represent the system output for yaw and yaw rate. 

% Settling time of approx 6sec for lateral velocity and yaw rate observed.

step(sys);
