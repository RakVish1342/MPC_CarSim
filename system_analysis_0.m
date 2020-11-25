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

a11 = (- Caf - Car)/(m*vx);
a12 = (- Caf*lf + Car*lr)/(m*vx*vx) - 1;
a21 = (- Caf*lf + Car*lr)/Iz;
a22 = (- Caf*lf*lf - Car*lr*lr)/(Iz*vx);

b11 = Caf/(m*vx);
b12 = Car/(m*vx);
b21 = (Caf*lf)/Iz;
b22 = -(Car*lr)/Iz;

c1 = 1;
c2 = 1;

A = [a11, a12; a21, a22];
B = [b11, b12; b21, b22];
C = [c1, 0; 0, c2]; % Both states are outputs...y = 2x1 required
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

