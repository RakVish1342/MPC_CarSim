function output = system_dynamics(input)

global A B % C D

x = input(1:4);
u = input(5:6);

x_dot = A*x + B*u;
% y = C*x + D*u;

% output = [x_dot, y];
output = [x_dot(2), x_dot(4)]; % y_ddot, phi_ddot


% x = input(1:2); % y_dot, phi_dot
% u = input(3:4); % del_f, del_r
% 
% t1 = (- 2*Caf - 2*Car)/(m*vx);
% t2 = (+2*Caf)/m;
% t3 = (+2*Car)/m;
% t4 = (+ 2*Car*lr - 2*Caf*lf)/(m*vx) - vx;
% 
% t5 = (+ 2*Car*lr - 2*Caf*lf)/(Iz*vx);
% t6 = (+2*Caf*lf)/Iz;
% t7 = (+2*Car*lr)/Iz;
% t8 = (- 2*Caf*lf*lf - 2*Car*lr*lr)/(Iz*vx);
% 
% 
% y_ddot = t1*y_dot + t2*u(1) + t3*u(2) + t4*phi_dot;
% phi_ddot = t5*y_dot + t6*u(1) + t7*u(2) + t8*phi_dot;
% 
% 
% output = [y_ddot, phi_ddot];


end